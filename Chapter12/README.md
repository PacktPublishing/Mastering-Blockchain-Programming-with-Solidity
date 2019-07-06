# Chapter 12: Building Your Own Token

You can skip the following commands to initialize the truffle project, as
the project is already initialized.
```bash
truffle init
npm init -y
```  

## Dependencies
* openzeppelin-solidity 2.2.0 
* chai 4.2.0
* big-number 2.0.0
* openzeppelin-test-helpers 0.3.1
* truffle-hdwallet-provider 1.0.6

 
The npm package dependencies are already present in the `package.json` file. 
To install all the above dependencies of the project, run the following command:
```bash
npm install
```

##### Compile
```bash
truffle compile
```

#### Ganache-cli
You can install `ganache-cli` using below command. Skip this if already installed.
```bash
npm install -g ganache-cli
```
Run ganache-cli in another window
```bash
ganache-cli
```

##### Run migration scripts
```bash
truffle migrate
``` 

##### Run test cases
```bash
truffle test
```

## On Testnet using Rinkeby

##### Deploy
```bash
truffle migrate --network rinkeby
```
