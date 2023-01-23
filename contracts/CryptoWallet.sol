//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

import {User} from './User.sol';
import {WalletModifiers} from './Modifiers.sol';

contract CryptoWallet is User,WalletModifiers{

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    // 0.000000000000000001 = 1 wei
    receive() payable external{}
    event AlertMsg(address useraddress,string message);

    /**
     * Function OpeningAccount
     * Added Two Modifiers AccountExist, MinumumValue
     * AccountExist ----> Will check whether the current msg.sender has already account or not
     * MinumumValue ----> will check whether the msg.value is equal to 1 or not
     */
    function OpeningAccount(address user,string memory name_) public payable  AccountExist MinumumValue{
        payable(address(this)).transfer(msg.value);
        emit AlertMsg(address(this),"Your amount has been debited to the bank account");
        uint balance = msg.value;
        Customer[user] = UserDeatails({
            name:name_,
            useraddress:user,
            saving_amount:Customer[user].saving_amount + balance
        });
        userarray.push(user);
        emit AlertMsg(user,"Acount Has Been Created Successfully...");
    }

    /**
     * Withdrwa from my Cryto Wallet to my origin Metamask wallet
    */
    function DepositeAmount() public payable DepositeValue{
        address isuser;
        payable(address(this)).transfer(msg.value);
        uint balance = msg.value;

        for(uint i = 0; i <= userarray.length-1; i++){
            if(userarray[i] == msg.sender){
                isuser = userarray[i];
                break;
            }
        }

        Customer[isuser].saving_amount = Customer[isuser].saving_amount + balance;
        emit AlertMsg(isuser,"Amout has been credited successfully...");
    }


    function GetAccount(address user) public view returns(UserDeatails memory acc){
        require(Customer[user].useraddress == user);
        acc = Customer[user];
        return acc;
    }

    function GetContractBalance() public view returns(uint){

        return address(this).balance;
    }


    function WithDraw(uint amount) public payable {
        address isuser;
        for(uint i = 0; i <= userarray.length-1; i++){
            if(userarray[i] == msg.sender){
                isuser = userarray[i];
                break;
            }
        }
        
        require(amount <= Customer[isuser].saving_amount);

        Customer[isuser].saving_amount = Customer[isuser].saving_amount - amount;

        require(amount <= address(this).balance);

        uint balance_left = address(this).balance - amount;

        payable(address(this)).transfer(balance_left);
        emit AlertMsg(address(this),"Amount has been deducted from the Contract...");

        payable(address(isuser)).transfer(address(this).balance - balance_left);
        emit AlertMsg(isuser,"Amount has succesfully been withdrawl to your account...");
    }
    

    function AccountBalance() public view returns(uint){ 

        return msg.sender.balance;
    }

}