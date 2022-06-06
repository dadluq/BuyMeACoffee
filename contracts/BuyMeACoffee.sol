//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Deployed to Goerli at 0x37208B32A55b52aB6ddaABc1B9C46A0d0D892EF3

contract BuyMeACoffee {
    // Event to emit when memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos recieved from friends
    Memo[] memos;

    // Address of contract deployer
    address payable owner;

    // Deploy logic. Constructor will only run when deployed.
    constructor() {
        owner = payable(msg.sender); 
    }

    /**
    * @dev buy a coffee for contract owner
    * @param _name name of coffee buyer
    * @param _message a nice message from the coffee buyer
    */

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "Can't buy coffee with 0 ETH");
        
        // Add the memo to storage!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log event when a new memo is created!
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }


    /**
    * @dev send the entire balance stored in this contract to the owner
    */
    function withdrawTips() public {
        require(owner.send(address(this).balance)); //whoever calls it will send to the owner address.

    }

    /**
    * @dev retrieve all the memos received and storred on the blockchain
    */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

}