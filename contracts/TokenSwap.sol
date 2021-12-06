//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract SwapToken{
    IERC20 public   AliceToken;
    address public Alice;   
    IERC20 public   BobToken;
    address public Bob;

    constructor(
        address _AliceToken,
        address _Alice,  
        address _BobToken,
        address _Bob
    ) {
        AliceToken = IERC20(_AliceToken);
        Alice = _Alice;
        BobToken = IERC20(_BobToken);
        Bob = _Bob;
    }
    function swap(uint _amount1, uint _amount2) public {
        require(msg.sender == Alice || msg.sender == Bob, "Not autorized");
        require(
            AliceToken.allowance(Alice, address(this)) >= _amount1,
            "Alice token to low"
        ); 
        require(
            BobToken.allowance(Bob, address(this)) >= _amount2,
            "Bob token to low"
        );
    // transfer tokens 
    _safeTransferFrom(AliceToken, Alice, Bob, _amount1);
    _safeTransferFrom(BobToken, Bob, Alice, _amount2);
    }

    function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer filed");
    }
}