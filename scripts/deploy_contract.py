#!/usr/bin/python3
import os
from brownie import MvpCollectible, accounts, network, config
from dotenv import load_dotenv

load_dotenv()


def main():
    dev = accounts.add(config["wallets"]["from_key"])
    print(network.show_active())
    # publish_source = True if os.getenv("ETHERSCAN_TOKEN") else False
    print(MvpCollectible.deploy({"from": dev}, publish_source=False))
