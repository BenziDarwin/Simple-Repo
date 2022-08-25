from brownie import MainSafe, network
from scripts.helpful_scripts import (
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
    FORKED_BLOCKCHAIN_ENVIRONMENTS,
)


def deploy():
    account = get_account()
    if (
        network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS
        or network.show_active() in FORKED_BLOCKCHAIN_ENVIRONMENTS
    ):
        print("Deploying using local/forked environment.")
        mainSafe = MainSafe.deploy({"from": account})
        print(mainSafe.address)
        return mainSafe
    else:
        if len(MainSafe) <= 0:
            print(f"Deploying on {network.show_active()}.")
            mainSafe = MainSafe.deploy({"from": account})
            return mainSafe
        else:
            return MainSafe[-1]


def main():
    deploy()
