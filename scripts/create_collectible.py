#!/usr/bin/python3
from brownie import MvpCollectible, accounts, network, config

metadata_template = {
    "name": "lol video",
    "description": "lol video",
    "video": "https://www.youtube.com/results?search_query=Faker+TF+Backdoor+-+SKT+vs+RNG+%E2%80%A2+WORLDS+2019",
    "attributes": [{"trait_type": "cuteness", "value": 100}],
}

def main():
    dev = accounts.add(config["wallets"]["from_key"])
    print(dev.address)
    dev_inter = accounts.add("26d3ee767995bd347584278bb88a9b8fd5dc7a58cc239b36db28e168ccb72292")
    # print(network.show_active())
    # print(len(MvpCollectible))
    # mvp_collectible = MvpCollectible[len(MvpCollectible) - 1]
    # token_id = mvp_collectible.tokenCounter()
    # print(token_id)
    #mvp_collectible.createCollectible(metadata_template, {"from": dev})
    #print(mvp_collectible.tokenURI(token_id))
    #mvp_collectible.setPrice(7, 0.01 * 10 ** 18, {"from": dev})
    #mvp_collectible.enableSell(3, {"from": dev})
    #mvp_collectible.enableSell(4, {"from": dev})
    # mvp_collectible.enableSell(6, {"from": dev})
    #mvp_collectible.enableSell(2, {"from": dev})
    # mvp_collectible.approve(dev_inter, 0, {"from": dev})
    # mvp_collectible.approve(dev_inter, 1, {"from": dev})
    # mvp_collectible.approve(dev_inter, 2, {"from": dev})
    # mvp_collectible.approve(dev_inter, 3, {"from": dev})
    #mvp_collectible.approve(dev_inter, 4, {"from": dev})
    #mvp_collectible.approve(dev_inter, 7, {"from": dev})
    #print(mvp_collectible.getIsForSelling(1, {"from": dev}))


    # print(mvp_collectible.tokenURI(0))
    #print(mvp_collectible.balanceOf('0xc24BC060a2305E35641c4A67F0Ee4aD932b2E083'))
    #transaction = mvp_collectible.createCollectible(metadata_template, {"from": dev})
    #transaction.wait(1)
    # print(
    #     "Awesome! You can view your NFT at {}".format(
    #         OPENSEA_FORMAT.format(mvp_collectible.address, token_id)
    #     )
    # )
   # print('Please give up to 20 minutes, and hit the "refresh metadata" button')
