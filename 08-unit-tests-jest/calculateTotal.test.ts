import { calculateTotal } from '../src/orders/calculateTotal';

describe('calculateTotal', () => {
  it('sums line items', () => {
    expect(calculateTotal([{"priceCents":1200,"qty":2},{"priceCents":500,"qty":1}])).toEqual(2900);
  });

  it('returns 0 for an empty cart', () => {
    expect(calculateTotal([])).toEqual(0);
  });

  it('rejects a negative quantity', () => {
    expect(() => calculateTotal([{"priceCents":1200,"qty":-1}])).toThrow("quantity");
  });

  it.todo('applies the loyalty discount');
});
