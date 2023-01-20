const { ethers, waffle} = require("hardhat");

describe("Cryptowallet Contract", function () {
    it("Account Opening", async function () {
        // Create the smart contract object to test from

        /**
         * Getting all the test accounts from hardhat network
         */
        const [owner,address1,address2] = await ethers.getSigners();
        const TestContract = await ethers.getContractFactory("CryptoWallet");
        // const TestContract2 = await ethers.getContractFactory("Test1");

        const contract = await TestContract.deploy();
        const tx = {
            to: contract.address,
            value: ethers.utils.parseEther('5', 'wei')
        };

        const create_account = await contract.connect(owner).OpeningAccount(owner.address,"Subhajit Ghosh",{value:ethers.utils.parseEther('2','ether')});
        // console.log(create_account)

        const get_account = await contract.GetAccount(owner.address);
        console.log(get_account)
        
        // await owner.sendTransaction(tx);


        // const balance = await contract.GetContractBalance({value:ethers.utils.parseEther('2','ether')});
        
        // const b = await contract.GetMyBal();
        // console.log(`Balance = ${b}`)
    });
});