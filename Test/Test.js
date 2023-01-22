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

        const contract = await TestContract.connect(owner).deploy();
        const tx = {
            to: contract.address,
            value: ethers.utils.parseEther('5', 'wei')
        };
        
        // 0.000000000000000001 = 1 wei
        const create_account = await contract.connect(owner).OpeningAccount(owner.address,"Subhajit Ghosh",{value:ethers.utils.parseEther('0.000000000000000010','wei')});
        // console.log(create_account)

        const deposite = await contract.DepositeAmount({value:ethers.utils.parseEther('0.000000000000000020','ether')});
        const myaccount_balance1 = await contract.AccountBalance();

        const debit_amount = await contract.WithDraw(10);

        const get_contract_balance = await contract.connect(owner).GetContractBalance();
        const get_account = await contract.GetAccount(owner.address);

        const myaccount_balance2 = await contract.AccountBalance();

        console.log(myaccount_balance1)
        console.log(myaccount_balance2)
        console.log(get_account)
        // console.log(debit_amount)
        console.log(get_contract_balance)

        // BigNumber { value: "9998997256710757850165" }
        // BigNumber { value: "9998997182486863895505" }

        // await owner.sendTransaction(tx);


        // const balance = await contract.GetContractBalance({value:ethers.utils.parseEther('2','ether')});
        
        // const b = await contract.GetMyBal();
        // console.log(`Balance = ${b}`)
    });
});