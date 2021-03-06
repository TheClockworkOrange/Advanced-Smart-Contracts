// SPDX-License-Identified: UNLICENSED

pragma solidity >0.4.0 <0.7.0;

contract StorageDemo {
    
    uint8 data1 = 1;
    uint8 data2 = 2;
    uint8 data3 = 3;
    uint8 data4 = 4;
    
    
    // get data3 and return it as output
    function getData() public view returns(bytes32 output3, bytes32 output4){
        assembly {
            let dataT3 := sload(data3_slot)
            let dataT4 := sload(data4_slot)
            let result3 :=  and(shr(shl(3,data3_offset), dataT3), 0xff)
            let result4 :=  and(shr(shl(3,data4_offset), dataT4), 0xff)
            mstore(0, result3)
            mstore(0x20, result4) // 0x20 is 32 bytes as result3 occupied 32 bytes
            // output := return(0,32)
            output3 := result3
            output4 := result4
        }
    }
}

// uint8 data3 = 3;
// 3 => 0x03 in 8 bit word size
// 3 => 0x0000000000000000000000000000000000000000000000000000000000000003 in 32 byte word size

// uint8 data4 = 4;
// 4 => 0x04 in 8 bit word size
// 4 => 0x0000000000000000000000000000000000000000000000000000000000000004 in 32 byte word size