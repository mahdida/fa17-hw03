pragma solidity ^0.4.15;

import "./AuctionInterface.sol";

/** @title GoodAuction */
contract GoodAuction is AuctionInterface {
	/* New data structure, keeps track of refunds owed to ex-highest bidders */
	mapping(address => uint) refunds;
	
	event bidMade(address _bider);

	/* Bid function, shifts to pull paradigm
	 * Must return true on successful send and/or bid, bidder
	 * reassignment
	 * Must return false on failure and allow people to
	 * retrieve their funds
	 */
	function bid() payable external returns(bool) {
		// YOUR CODE HERE
		if(msg.value <= highestBid){
		    refunds[msg.sender] += msg.value;
		    return false;
		}
		else{
		    refunds[msg.sender] += msg.value;
		    highestBidder = msg.sender;
		    highestBid = msg.value;
		    emit bidMade(msg.sender);
		    return true;
		}
	}

	/* New withdraw function, shifts to pull paradigm */
	function withdrawRefund() external returns(bool) {
		// YOUR CODE HERE
		require(refunds[msg.sender] > 0);
		if(refunds[msg.sender] <= 0){
		    return false;
		}
		else{
		    msg.sender.transfer(refunds[msg.sender]);
		    refunds[msg.sender] = 0;
		    return true;
		}
	}

	/* Allow users to check the amount they can withdraw */
	function getMyBalance() constant external returns(uint) {
		return refunds[msg.sender];
	}

	/* Give people their funds back */
	function () payable {
		// YOUR CODE HERE
		revert();
    }
}
