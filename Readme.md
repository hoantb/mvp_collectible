# mvp_collectible

This is a repo to work with and use NFTs smart contracts in a python environment, using the Chainlink-mix as a starting point. 

## Prerequisites

Please install or have installed the following:

- [nodejs and npm](https://nodejs.org/en/download/)
- [python](https://www.python.org/downloads/)
## Installation

1. [Install Brownie](https://eth-brownie.readthedocs.io/en/stable/install.html), if you haven't already. Here is a simple way to install brownie.

```bash
pip install eth-brownie
```
Or, if that doesn't work, via pipx
```bash
pip install --user pipx
pipx ensurepath
# restart your terminal
pipx install eth-brownie
```

2. Clone this repo
```
https://github.com/hoantb/mvp_collectible
cd mvp
```

1. [Install ganache-cli](https://www.npmjs.com/package/ganache-cli)

```bash
npm install -g ganache-cli
```

If you want to be able to deploy to testnets, do the following. 

4. Set your environment variables

Set your `WEB3_INFURA_PROJECT_ID`, and `PRIVATE_KEY` [environment variables](https://www.twilio.com/blog/2017/01/how-to-set-environment-variables.html). 

You can get a `WEB3_INFURA_PROJECT_ID` by getting a free trial of [Infura](https://infura.io/). At the moment, it does need to be infura with brownie. You can find your `PRIVATE_KEY` from your ethereum wallet like [metamask](https://metamask.io/). 

You'll also need testnet BSC
You can add your environment variables to the `.env` file:

```
export WEB3_INFURA_PROJECT_ID=<PROJECT_ID>
export PRIVATE_KEY=<PRIVATE_KEY>
```

AND THEN RUN `source .env` TO ACTIVATE THE ENV VARIABLES
(You'll need to do this everytime you open a new terminal, or [learn how to set them easier](https://www.twilio.com/blog/2017/01/how-to-set-environment-variables.html))


Or you can run the above in your shell. 


# Useage

MvpCollectibles is type of NFT for video games, we can sell them on the website.

You can 100% use the BSC testnet to see your NFTs rendered
### Running Scripts

The MvpCollectible work on bsc-test, however you can change networks.

You'll need [testnet BSC](https://testnet.binance.org/faucet-smart) and the wallet associated with your private key. 

```
brownie run scripts/deploy_collectible.py --network bsc-test
brownie run scripts/create_collectible.py --network bsc-test

```
Then:
```
brownie run scripts/buy_collectible.py --network bsc-test
```

## References

nft-mix
