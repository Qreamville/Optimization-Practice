// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract Distribute {
    address payable immutable contributor1;
    address payable immutable contributor2;
    address payable immutable contributor3;
    address payable immutable contributor4;
    uint256 immutable createTime;

    constructor(address[4] memory _contributors) payable {
        contributor1 = payable(_contributors[0]);
        contributor2 = payable(_contributors[1]);
        contributor3 = payable(_contributors[2]);
        contributor4 = payable(_contributors[3]);
        createTime = block.timestamp + 1 weeks;
    }

    function distribute() external {
        require(block.timestamp > createTime, "cannot distribute yet");

        uint256 amount = address(this).balance >> 2;
        payable(contributor1).send(amount);
        payable(contributor2).send(amount);
        payable(contributor3).send(amount);
        selfdestruct(payable(contributor4));
    }
}
