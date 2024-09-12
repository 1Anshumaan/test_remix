// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PotatoTransport {
    // Potato Listing
    struct PotatoListing {
        address farmer;
        uint256 quantity;
        uint256 price;
        uint256 deliveryTimeline;
    }
    mapping(uint256 => PotatoListing) public potatoListings;
    uint256 public potatoListingCount;

    // Buyer Ordering
    struct Order {
        address buyer;
        uint256 potatoListingId;
        uint256 quantity;
        uint256 totalPrice;
        bool delivered;
    }
    mapping(uint256 => Order) public orders;
    uint256 public orderCount;

    // Modifiers
    modifier onlyFarmer(uint256 _potatoListingId) {
        require(msg.sender == potatoListings[_potatoListingId].farmer, "Only the farmer can perform this action.");
        _;
    }

    modifier onlyBuyer(uint256 _orderId) {
        require(msg.sender == orders[_orderId].buyer, "Only the buyer can perform this action.");
        _;
    }

    // Functions
    function createPotatoListing(uint256 _quantity, uint256 _price, uint256 _deliveryTimeline) public {
        potatoListings[potatoListingCount] = PotatoListing(msg.sender, _quantity, _price, _deliveryTimeline);
        potatoListingCount++;
    }

    function placeOrder(uint256 _potatoListingId, uint256 _quantity) public payable {
        require(_quantity <= potatoListings[_potatoListingId].quantity, "Requested quantity exceeds available inventory.");
        require(msg.value >= potatoListings[_potatoListingId].price * _quantity, "Insufficient payment.");

        orders[orderCount] = Order(msg.sender, _potatoListingId, _quantity, potatoListings[_potatoListingId].price * _quantity, false);
        orderCount++;
    }

    function confirmDelivery(uint256 _orderId) public onlyBuyer(_orderId) {
        require(!orders[_orderId].delivered, "Delivery has already been confirmed.");
        orders[_orderId].delivered = true;
        payable(potatoListings[orders[_orderId].potatoListingId].farmer).transfer(orders[_orderId].totalPrice);
    }

    function disputeDelivery(uint256 _orderId) public onlyBuyer(_orderId) {
        require(orders[_orderId].delivered, "Delivery has not been confirmed yet.");
        // Implement dispute resolution logic here
    }
}