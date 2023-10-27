pragma solidity ^0.8.17;

contract ticketSale {
    address public owner;
    uint public price;
    uint public numTickets;

    struct ticket {
        uint id;
        address owner;
        address swapAddress;
    }

    mapping(uint => ticket) public ticket_map;

    // SOME ADDITIONAL UTILITY FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    function sendEther(uint payment, address recipient) public payable returns (bool, bytes memory){
        bool success;
        bytes memory data;
        (success, data) = recipient.call{value: payment}("");
        return (success, data);
    }

    function createTickets() private {
        uint i;
        for (i=1; i<=numTickets; i++){
            ticket_map[i] = ticket(i, address(0), address(0));
        }
    }

    function isAvailable(uint ticketID) view private returns (bool){
        if (ticket_map[ticketID].owner == address(0)){
            return true;
        }
        return false;
    }

    function hasBoughtTicket(address buyer_address) view private returns (bool){
        uint i;
        for (i=1; i<=numTickets; i++){
            if (ticket_map[i].owner == buyer_address) return true;
        }
        return false;
    }
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    constructor(uint arg_numTickets, uint arg_price){
        owner = msg.sender;
        numTickets = arg_numTickets;
        price = arg_price;
        createTickets();
    }

    function buyTicket(uint ticketId) public payable{
        require(isAvailable(ticketId), "The ticket has already been purchased");
        require(!hasBoughtTicket(msg.sender), "This address has already bought a ticket");
        require(msg.value >= price, "Not enough Wei");
        ticket_map[ticketId].owner = msg.sender;
        sendEther(price, owner);
    }

    function getTicketOf(address person) view  public returns (uint){
        uint i;
        for (i=1; i<=numTickets; i++){
            if (ticket_map[i].owner == person) return i;
        }
        return 0;
    }

    function offerSwap(address partner) public {
        uint ticketID = getTicketOf(msg.sender);
        require(msg.sender != partner, "cannot swap with self");
        require(ticketID!=0, "Caller has no ticket");
        require(getTicketOf(partner)!=0, "Cannot swap with someone who owns no ticket");
        ticket_map[ticketID].swapAddress = partner;
    }

    function acceptSwap(address partner) public {
        uint ticketID_caller = getTicketOf(msg.sender);
        require(ticketID_caller!=0, "Caller has no ticket");
        uint ticketID_swaper = getTicketOf(partner);
        require(ticketID_caller!=0, "address given has no ticket");
        require(ticket_map[ticketID_swaper].swapAddress == msg.sender, "No offer to accept from given address");
        
        ticket_map[ticketID_caller].owner = partner;

        ticket_map[ticketID_swaper].owner = msg.sender;
        ticket_map[ticketID_swaper].swapAddress = address(0);
    }

    function returnTicket(uint ticketId) public payable{
        require(msg.sender == owner, "Only owner can return tickets");
        require(!isAvailable(ticketId), "the ticket has not yet been purchased");
        uint return_payment = price * 90 / 100; //solidity is weird about percentages
        require(msg.value >= return_payment, "Not enough Wei");
        sendEther(return_payment, ticket_map[ticketId].owner);
        ticket_map[ticketId].owner = address(0);
        ticket_map[ticketId].swapAddress = address(0);
    }
    
}


/*
  '0x74275c8f57112beE7bD519e7Ce2e67D01eA03121',
  '0x0227F3a2f0259e82573e1Bc4b8FD7a0837B5c74c',
  '0xffEe8c6C61487907AFFCe10497aE561b04426d9A',
  '0xea278E7BEf6818F035D6E7C2f1a80A2b6c6f37F1',
  '0x2a35313feeA31bFf91062FE7EbfA65D28542Fc96',
  '0x4EfDb9049EB9FD7D1652fC1352111a991E75319F',
  '0x247A02CeC5373C68dE916824EC59Eb368b6197E3',
  '0x908B9fdAA2343E1Fe5d160933a109CA3F039f368',
  '0x7720F9CFdEA695FF470c4215B2420066a133F190',
  '0x749EaB580DBb79dFA98C59bbf79f5F295AC7518E'
]
    ✔ deploys (89ms)
    ✔ allows users to buy tickets (335ms)
    ✔ can see what ticket an address owns (403ms)
    ✔ allows swapping of tickets (1727ms)
    ✔ allows the owner to return tickets (654ms)


  5 passing (6s)
  */

  /*
  Deploy.js error

  Error: Invalid number of parameters for "undefined". Got 1 expected 2!
    at Object.InvalidNumberOfParams (C:\Workspace\CSC494\Assignment 3\node_modules\web3-core-helpers\lib\errors.js:33:16)
    at Object._createTxObject (C:\Workspace\CSC494\Assignment 3\node_modules\web3-eth-contract\lib\index.js:712:22)
    at Contract.deploy (C:\Workspace\CSC494\Assignment 3\node_modules\web3-eth-contract\lib\index.js:526:33)
    at deploy (C:\Workspace\CSC494\Assignment 3\deploy.js:27:6)

Node.js v18.18.0
*/
