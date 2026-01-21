const buyTokens = async (contract, amount, valueInWei) => {
    const tx = await contract.buy(amount, { value: valueInWei });
    return await tx.wait();
};
