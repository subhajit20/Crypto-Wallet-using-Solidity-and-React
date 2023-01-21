//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

import {User} from './User.sol';
import {WalletModifiers} from './Modifiers.sol';

contract CryptoWallet is User,WalletModifiers{
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
        uint balance = msg.value;
        Customer[user] = UserDeatails({
            name:name_,
            useraddress:user,
            saving_amount:Customer[user].saving_amount + balance
        });
        userarray.push(user);
        emit AlertMsg(user,"Acount Has Been Created Successfully...");
    }

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


    function GetAccount(address user) public view returns(UserDeatails memory ud){
        require(Customer[user].useraddress == user);
        ud = Customer[user];
        return ud;
    }

    function GetContractBalance() public view returns(uint){
        return address(this).balance;
    }


    function DebitAmount() public payable {
        address isuser;
        for(uint i = 0; i <= userarray.length-1; i++){
            if(userarray[i] == msg.sender){
                isuser = userarray[i];
                break;
            }
        }
        
        require(msg.value <= Customer[isuser].saving_amount);

        payable(isuser).transfer(msg.value);
    }

    function AccountBalance() public view returns(uint){ 
        return msg.sender.balance;
    }

}