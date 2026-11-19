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
  it('GET /orders/1', () => {
    pact
      .uponReceiving('GET /orders/1')
      .withRequest({
        method: 'GET',
        path: '/orders/1',
      })
      .willRespondWith({
        status: 200,
      });

    return pact.executeTest(async (mockServer) => {
      const res = await fetch(`${mockServer.url}/orders/1`, { method: 'GET' });
      expect(res.status).toBe(200);
    });
  });

  it('creates an order', () => {
    pact
      .given('a cart exists')
      .uponReceiving('creates an order')
      .withRequest({
        method: 'POST',
        path: '/orders',
        headers: { 'Content-Type': 'application/json' },
        body: {"qty":2,"sku":"A1"},
      })
      .willRespondWith({
        status: 201,
        headers: { 'Content-Type': 'application/json' },
        body: like({"id":"o-1","status":"pending"}),
      });

    return pact.executeTest(async (mockServer) => {
      const res = await fetch(`${mockServer.url}/orders`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({"qty":2,"sku":"A1"}) });
      expect(res.status).toBe(201);
        expect(await res.json()).toEqual({"id":"o-1","status":"pending"});
    });
  });
});
