# Developing for Ethereum

1. install truffle with `sudo npm install -g truffle` 
2. install testrpc with `sudo npm install -g ethereumjs-testrpc`

once the repository is cloned, run `npm install` in `root` and `app` folders

# Implemented use case

for this demo we will develop a simple use case where a product is sold, 
delivered and litigated over.
 
The steps are.

1. a seller puts a product up for sale
1. a buyer pays the security and orders the product
1. the seller takes a picture of the parcel and the content as they leave the warehouse
1. the transporter takes a picture of the parcel on the last leg of its journey before it is delivered
1. the product is delivered and the contract is informed of the delivery
1. the buyer raises a concern and publishes a picture of the content
1. the seller refuses to reimburse because the buyer did not choose transport insurance
1. because the buyer still refuses to free the security, an arbitrator is called upon
1. the arbitrator looks at the evidence and makes a decision
1. the security is freed
