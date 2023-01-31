# Chain link automation example

This project is an example of Chainlink automation

## Installation
You need to have [nodejs](https://nodejs.org/en/) to install this project

After installing the nodejs, you have to install [truffle](https://trufflesuite.com/) and [ganache](https://github.com/trufflesuite/ganache/tree/develop/src/packages/ganache#readme)
```bash
npm install -g truffle
npm install -g ganache
```

## Configuring your environment
Create a file called .env end put this variable inside it:

```.env
MNEMONIC = "PUT your seed here"
```


## Initializing project locally

Open the project's folder then execute those commands
```bash
npm install
npm run start_local
truffle migrate
```

## If you want to migrate it to the mumbai execute those commands
```bash
npm install
truffle migrate --network mumbai 
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Contribution
NFT images was made by [Fabio](https://github.com/smartsecbr).
Thanks for this, man!
