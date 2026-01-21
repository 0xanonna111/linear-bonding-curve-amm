async function main() {
    const BND = await ethers.getContractFactory("BondingCurveToken");
    const bnd = await BND.deploy();
    console.log("Bonding Curve Token deployed to:", bnd.address);
}
