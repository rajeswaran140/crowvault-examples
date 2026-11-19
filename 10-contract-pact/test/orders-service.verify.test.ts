import { Verifier } from '@pact-foundation/pact';
import * as path from 'path';

describe('orders-service honours the orders-web contract', () => {
  it('verifies the pact', () =>
    new Verifier({
      provider: 'orders-service',
      providerBaseUrl: process.env.PROVIDER_URL ?? 'http://localhost:3000',
      pactUrls: [path.resolve(__dirname, '../pacts/orders-web-orders-service.json')],
      stateHandlers: {
        'order 7f3c9a2e-0000-4000-8000-000000000001 exists': async () => {
          // TODO: seed: order 7f3c9a2e-0000-4000-8000-000000000001 exists
        },
        'customer 0b6d1f4a-0000-4000-8000-000000000002 exists': async () => {
          // TODO: seed: customer 0b6d1f4a-0000-4000-8000-000000000002 exists
        },
      },
    }).verifyProvider());
});
