import { Verifier } from '@pact-foundation/pact';
import * as path from 'path';

describe('orders-service honours the orders-web contract', () => {
  it('verifies the pact', () =>
    new Verifier({
      provider: 'orders-service',
      providerBaseUrl: process.env.PROVIDER_URL ?? 'http://localhost:3000',
      pactUrls: [path.resolve(__dirname, '../pacts/orders-web-orders-service.json')],
      // stateHandlers: { 'an order exists': async () => { /* seed data */ } },
    }).verifyProvider());
});
