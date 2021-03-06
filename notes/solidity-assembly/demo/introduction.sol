// SPDX-License-Identifier: UNLICENSED

pragma solidity >0.4.0 <0.7.0;

contract Sample {
    
    function helloFn() public  pure returns(string memory name){
        assembly {
            let x := 1
            let y := "Hello World"
            name := y
        }
    }
    
    function fnAdd(uint input) public pure returns(uint x, uint y) {
        assembly {
            function f(val) -> a,b {
                a := add(val,1)
                b := val
            }
            x, y := f(input)
        }
    }
    
    function fnSwitch(uint input)  public pure returns(uint b){
        assembly {
            switch input
                case 0 { b := 12 }
                case 1 { b := 13 }
                case 100 { b := 13 }
                default { b := add(input,1) } // mul, div, sub
        }
    }
    
    function fnLoop(uint max) public pure returns(uint result) {
        assembly {
            for { let i := 0 }
             lt(i, 20)
             { i := add(i,1) }
             {
                 if lt(i,3) { continue }
                 if gt(i , max) { break }
                 result := add(result,1)
             }
        }
    }
    
    function getCode(address contractAddress) public view returns(bytes memory codehash) {
        assembly {
            codehash := extcodehash(contractAddress)
        }
    }
    
    function srTest(uint8 x) public pure returns(uint8  result) {
        assembly {
            result := shr(1,x)
        }
    }
    
    function countUnsetBit(uint8 data) public pure returns (uint8 result) {
        for(uint i = 0; i < 8 ; i = i + 1) {
            if ( ((data >> i) & 1) == 0){
                result += 1;
            }
        }
    }
    
    function countUnsetBitInAsm(uint8 data) public pure returns (uint8 result) {
        assembly {
            for {let i := 0 }
             lt(i,8)
            { i := add(i,1)}{
                let byteShifted := shr(i, data)
                let andedResult := and(byteShifted,1)
                if eq(andedResult,0){
                    result := add(result,1)
                }
            }
        }
    }
    
    
 }

 // 00001111 => 15
 // 00000111 => 7
 
 // num1 00001111
 // num2 10101010
 // res  00001010
 
 
 