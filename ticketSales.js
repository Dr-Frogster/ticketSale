import web3 from './web3';

const address='0x59DB9fD60144bAfd170C8548b7c772F7ff946c6e';

const abi= [{"inputs":[{"internalType":"uint256","name":"arg_numTickets","type":"uint256"},{"internalType":"uint256","name":"arg_price","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"address","name":"partner","type":"address"}],"name":"acceptSwap","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"ticketId","type":"uint256"}],"name":"buyTicket","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"person","type":"address"}],"name":"getTicketOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"numTickets","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"partner","type":"address"}],"name":"offerSwap","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"price","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"ticketId","type":"uint256"}],"name":"returnTicket","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"payment","type":"uint256"},{"internalType":"address","name":"recipient","type":"address"}],"name":"sendEther","outputs":[{"internalType":"bool","name":"","type":"bool"},{"internalType":"bytes","name":"","type":"bytes"}],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"ticket_map","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"swapAddress","type":"address"}],"stateMutability":"view","type":"function"}]

export default new web3.eth.Contract(abi, address);