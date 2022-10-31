pragma solidity 0.8.7;

contract test2{

  address public owner;

  constructor(){
    owner = msg.sender;
  }

  modifier onlyOwner(){
    require(msg.sender == owner, "[WARNING] ---- NOT OWNER ---- [WARNING]");
    _;
  }

  struct wallet{
    uint balance;
    uint numPayments;
  }

  mapping(address => wallet) Wallets;

  function getTotalBalance() external onlyOwner returns(uint) {
    return address(this).balance;
  }

  function getBalance() external onlyOwner returns(uint) {
    return Wallets[msg.sender].balance;
  }

  function withdrawAllMoney(address payable _to) external onlyOwner {
    uint _amount = Wallets[msg.sender].balance;
    Wallets[msg.sender].balance = 0;
    _to.transfer(_amount);
  }

  function setOwner(address _newOwner) external onlyOwner{
    require(_newOwner != address(0), "[WARNING] ---- INVALID ADDRESS  ---- [WARNING]" );
    owner = _newOwner;
  }

  receive() external payable {
    Wallets[msg.sender].balance += msg.value;
    Wallets[msg.sender].numPayments += 1;
  }

}