pragma solidity ^0.4.2;

contract Zillerium {

  struct User {
    string firstName;
    string lastName;
    uint balance;
  }

  struct Product {
    string manufacturer;
    string model;
    string listPrice;
  }

  struct DeliveryMethod {
    string name;
    bool insurance;
    uint price;
  }

  struct CatalogEntry {
    Product product;
    address seller;
    uint offeredPrice;
    bool arbitration; //will an arbitrator be called upon in case of litigation
  }

  event Purchase(
    address indexed buyer,
    uint catalogEntry,
    uint timeStamp,
    bool transportInsurance
  );

  mapping (uint=>Product) products;
  mapping (address=>User) users;
  mapping (string=>CatalogEntry) catalogEntries;
  mapping (uint=>CatalogEntry) purchases;

  uint catalogEntriesCount;
  uint purchasesCount;

address owner;

  modifier ownerOnly() {
    if (msg.sender == owner) _;
    throw;
  }

  function Zillerium(string firstName, string lastName) {
    owner = msg.sender;
    User memory user;
    user.firstName = firstName;
    user.lastName = lastName;
    user.balance = 1000000000000;
    users[owner] = user;
  }

  function transfer(uint amount, address sender, address recipient) {
    if(users[sender].balance < amount) 
      throw;

    users[sender].balance -= amount;
    users[recipient].balance += amount;
  }

  function addCatalogEntry(uint product, uint price, bool arbitration) {
    CatalogEntry memory catalogEntry;
    catalogEntry.seller = msg.sender;
    catalogEntry.product = products[product];
    catalogEntry.offeredPrice = price;
    catalogEntry.arbitration = arbitration;
  }

}