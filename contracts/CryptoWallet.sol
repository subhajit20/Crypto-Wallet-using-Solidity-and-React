//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

import {User} from './User.sol';

contract CryptoWallet is User{

    receive() payable external{}
    uint my_bal;

    event AlertMsg(address useraddress,string message);

    function OpeningAccount(address user,string memory name_) public payable{
        require(Customer[user].useraddress != user);
        require(msg.value != 1 ether);
        payable(address(this)).transfer(msg.value);

        my_bal = msg.value;

        Customer[user] = UserDeatails({
            name:name_,
            useraddress:user,
            saving_amount:Customer[user].saving_amount + my_bal
        });
        userarray.push(user);
        emit AlertMsg(user,"Acount Has Been Created Successfully...");
    }

    function GetAccount(address user) public view returns(UserDeatails memory ud){
        require(Customer[user].useraddress == user);
        ud = Customer[user];
        return ud;
    }

    function GetContractBalance() public payable {
        require(msg.value != 1 ether);
        payable(address(this)).transfer(msg.value);
        my_bal =  msg.value - 1;
    }

    function GetMyBal() public view returns(uint) {
        uint b = my_bal;

        return b;
    }

}