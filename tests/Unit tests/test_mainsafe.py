from brownie import MainSafe, network
from scripts.deploy import deploy
from scripts.helpful_scripts import LOCAL_BLOCKCHAIN_ENVIRONMENTS, get_account
import pytest


def test_deploy():
    if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        mainSafe = deploy()
        assert mainSafe.address != None
    else:
        pytest.skip("Local networks only!")


def test_addUser():
    account = get_account()
    mainsafe = deploy()
    tx = mainsafe.addUser(account, {"from": account})
    tx.wait(1)
    assert mainsafe.users(0) == account


def test_withdraw():
    account = get_account()
    mainsafe = deploy()
    payable(account).transfer(mainsafe.address, "2 ether")
    tx = mainsafe.withdraw({"from": account})
    tx.wait(1)
