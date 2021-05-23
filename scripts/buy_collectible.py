#!/usr/bin/python3
from brownie import MvpCollectible, accounts, network, config
from brownie.network import gas_price, main
metadata_template = {
    "name": "lol video",
    "description": "lol video",
    "thumbnail": "",
    "video": "https://www.youtube.com/results?search_query=Faker+TF+Backdoor+-+SKT+vs+RNG+%E2%80%A2+WORLDS+2019",
    "attributes": [{"trait_type": "cuteness", "value": 100}],
}

def main():
    dev1 = accounts.add(config["wallets"]["from_key"])
    dev2 = accounts.add("0a1b66412a72aeda06bfc77e543b8cb22af259b6370a684a5c28a39307412b85")
    mvp_collectible = MvpCollectible[len(MvpCollectible) - 1]
    token_id = mvp_collectible.tokenCounter() - 1
    print(mvp_collectible.ownerOf(token_id))
    mvp_collectible.approve(dev2, token_id, {"from": dev1})
    a = dev1.balance()
    mvp_collectible.buy(token_id, {"from": dev2, "value": "0.01 ether"})
    print(a - dev1.balance())


