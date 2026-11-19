// Reference implementation used only to run the generated tests (not part of the example).
export function calculateTotal(items: { priceCents: number; qty: number }[]): number {
  return items.reduce((sum, i) => {
    if (i.qty < 0) throw new Error('quantity must not be negative');
    return sum + i.priceCents * i.qty;
  }, 0);
}
