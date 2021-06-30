const Oracles = artifacts.require("Oracles.sol");
const Consumer = artifacts.require("Consumer.sol");

module.exports = async function (deployer,_network,addresses) {
    const[admin,reporter,_] = addresses;
    await deployer.deploy(Oracles,admin);
    const oracle = await Oracles.deployed();  
    await oracle.updateReporter(reporter,true);
    await deployer.deploy(Consumer,oracle.address);
     
};
