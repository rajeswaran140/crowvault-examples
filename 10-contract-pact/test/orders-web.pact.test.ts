import { PactV3, MatchersV3 } from '@pact-foundation/pact';
import * as path from 'path';

const { like } = MatchersV3;

const pact = new PactV3({
  consumer: 'orders-web',
  provider: 'orders-service',
  dir: path.resolve(__dirname, '../pacts'),
  logLevel: 'warn',
});

describe('orders-web → orders-service contract', () => {
  it('gets an order', () => {
    pact
      .given('order 7f3c9a2e-0000-4000-8000-000000000001 exists')
      .uponReceiving('gets an order')
      .withRequest({
        method: 'GET',
        path: '/v1/orders/7f3c9a2e-0000-4000-8000-000000000001',
      })
      .willRespondWith({
        status: 200,
        headers: { 'Content-Type': 'application/json' },
        body: like({"currency":"USD","customer_id":"0b6d1f4a-0000-4000-8000-000000000002","id":"7f3c9a2e-0000-4000-8000-000000000001","status":"pending","total_cents":2900}),
      });

    return pact.executeTest(async (mockServer) => {
      const res = await fetch(`${mockServer.url}/v1/orders/7f3c9a2e-0000-4000-8000-000000000001`, { method: 'GET' });
      expect(res.status).toBe(200);
        expect(await res.json()).toEqual({"currency":"USD","customer_id":"0b6d1f4a-0000-4000-8000-000000000002","id":"7f3c9a2e-0000-4000-8000-000000000001","status":"pending","total_cents":2900});
    });
  });

  it('creates an order', () => {
    pact
      .given('customer 0b6d1f4a-0000-4000-8000-000000000002 exists')
      .uponReceiving('creates an order')
      .withRequest({
        method: 'POST',
        path: '/v1/orders',
        headers: { 'Content-Type': 'application/json' },
        body: {"currency":"USD","customer_id":"0b6d1f4a-0000-4000-8000-000000000002","status":"pending","total_cents":2900},
      })
      .willRespondWith({
        status: 201,
        headers: { 'Content-Type': 'application/json' },
        body: like({"currency":"USD","customer_id":"0b6d1f4a-0000-4000-8000-000000000002","id":"7f3c9a2e-0000-4000-8000-000000000001","status":"pending","total_cents":2900}),
      });

    return pact.executeTest(async (mockServer) => {
      const res = await fetch(`${mockServer.url}/v1/orders`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({"currency":"USD","customer_id":"0b6d1f4a-0000-4000-8000-000000000002","status":"pending","total_cents":2900}) });
      expect(res.status).toBe(201);
        expect(await res.json()).toEqual({"currency":"USD","customer_id":"0b6d1f4a-0000-4000-8000-000000000002","id":"7f3c9a2e-0000-4000-8000-000000000001","status":"pending","total_cents":2900});
    });
  });
});
