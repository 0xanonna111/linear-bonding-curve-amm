/**
 * Predicts the cost of buying N tokens given current supply
 * Formula: Cost = n * (b + m * (supply + n/2))
 */
export function getLinearCost(n, supply, m, b) {
    return n * (b + m * (supply + n / 2));
}
