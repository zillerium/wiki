pragma solidity ^0.4.2;

contract Zillerium {

  struct User {
    address addr;
    string firstName;
    string lastName;
    uint balance;
  }

  struct Product {
    string manufacturer;
    string model;
    uint listPrice;
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
    address indexed seller,
    uint catalogEntry,
    uint timeStamp,
    bool transportInsurance
  );

  mapping (uint=>Product) products;
  mapping (address=>User) users;
  mapping (uint=>CatalogEntry) catalogEntries;
  mapping (uint=>CatalogEntry) purchases;

  uint usersCount;
  uint productsCount;
  uint catalogEntriesCount;
  uint purchasesCount;

address owner;

  modifier ownerOnly() {
    if (msg.sender == owner) _;
    throw;
  }

  modifier usersOnly(address user) {
    if (users[user].addr == address(0x0)) throw;
    _;
  }

  function Zillerium(string firstName, string lastName) {
    owner = msg.sender;
    User memory user;
    user.firstName = firstName;
    user.lastName = lastName;
    user.balance = 1000000000000;
    user.addr = owner;
    users[owner] = user;
  }

  function addUser(string firstName, string lastName) {
    User memory user;
    user.firstName = firstName;
    user.lastName = lastName;
    users[msg.sender] = user;
  }

  function transfer(uint amount, address sender, address recipient) {
    if(users[sender].balance < amount) 
      throw;

    users[sender].balance -= amount;
    users[recipient].balance += amount;
  }

  function addProduct(string manufacturer, string model, uint listPrice) usersOnly(msg.sender) returns (uint){
    Product memory product;
    product.manufacturer = manufacturer;
    product.model = model;
    product.listPrice = listPrice;
    products[++productsCount] = product;
    return productsCount;
  }

  function addCatalogEntry(uint product, uint price, bool arbitration) usersOnly(msg.sender) returns(uint){
    CatalogEntry memory catalogEntry;
    catalogEntry.seller = msg.sender;
    catalogEntry.product = products[product];
    catalogEntry.offeredPrice = price;
    catalogEntry.arbitration = arbitration;
    catalogEntries[(++catalogEntriesCount)] = catalogEntry;
    return catalogEntriesCount-1;
  }

}