import { test, expect, devices } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test.describe('checkout', () => {
  test('loads without errors', async ({ page }) => {
    const consoleErrors: string[] = [];
    const failedRequests: string[] = [];
    page.on('console', (msg) => { if (msg.type() === 'error') consoleErrors.push(msg.text()); });
    page.on('requestfailed', (req) => failedRequests.push(req.url()));

    const response = await page.goto('/');
    expect(response?.ok(), `status ${response?.status()}`).toBe(true);
    await expect(page).toHaveTitle(/\S/);
    await expect(page.locator('body')).toBeVisible();
    expect(consoleErrors).toEqual([]);
    expect(failedRequests).toEqual([]);
  });

  test('internal links resolve', async ({ page, request }) => {
    await page.goto('/');
    const hrefs = await page.locator('a[href]').evaluateAll((as) =>
      [...new Set(as.map((a) => (a as HTMLAnchorElement).href).filter((h) => h.startsWith(location.origin)))].slice(0, 20),
    );
    for (const href of hrefs) {
      const res = await request.get(href);
      expect(res.status(), href).toBeLessThan(400);
    }
  });

  test('has no serious accessibility violations', async ({ page }) => {
    await page.goto('/');
    const { violations } = await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa']).analyze();
    const serious = violations.filter((v) => v.impact === 'serious' || v.impact === 'critical');
    expect(serious.map((v) => `${v.id}: ${v.help}`)).toEqual([]);
  });

  test('checkout flow', async ({ page }) => {
    await page.goto('/');
    await page.locator('#add-to-cart').click();
    await page.goto('/cart');
    await page.locator('input[name=email]').fill('jane@example.com');
    await page.locator('button[type=submit]').click();
    await expect(page).toHaveURL(/\/order\-confirmed/);
    await expect(page.locator('h1')).toContainText('Thank you');
  });
});

test.describe('checkout — mobile', () => {
  test.use({ ...devices['iPhone 13'] });

  test('renders without horizontal scroll', async ({ page }) => {
    await page.goto('/');
    const overflow = await page.evaluate(() => document.documentElement.scrollWidth > window.innerWidth);
    expect(overflow).toBe(false);
  });
});
