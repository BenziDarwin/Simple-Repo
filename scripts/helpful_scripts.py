from brownie import accounts, config, network

LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["ganache-cli", "development"]
FORKED_BLOCKCHAIN_ENVIRONMENTS = ["mainnet-fork-dev"]
TESTNET_ENVIRONMENTS = ["rinkeby", "kovan", "goerli"]


def get_account():
    if (
        network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS
        or network.show_active() in FORKED_BLOCKCHAIN_ENVIRONMENTS
    ):
        return accounts[0]
    else:
        if network.show_active() in TESTNET_ENVIRONMENTS:
            return accounts.add(config["wallets"]["keys"]["test_key"])
        else:
            return accounts.add(config["wallets"]["keys"]["key"])
