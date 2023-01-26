//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;
import {User} from './User.sol';


contract WalletModifiers is User{

    modifier AccountExist{
        require(Customer[msg.sender].useraddress != msg.sender);
        _;
    }

    modifier isValidAccount{
        require(Customer[msg.sender].useraddress == msg.sender);
        _;
    }

   modifier MinumumValue{
      require(msg.value == 10 wei);
      _;
   }

   modifier DepositeValue{
      require(msg.value >= 10 wei);
      _;
   }


}