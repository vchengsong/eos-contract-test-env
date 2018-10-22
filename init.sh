#!/bin/bash


#CONTRACTS_DIR=/Users/song/tmp/contracts
#CONTRACTS_DIR=/Code/github.com/vchengsong/eos/build/contracts
CONTRACTS_DIR=/Code/github.com/vchengsong/eosio.contracts/build


WALLET_DIR=/Users/song/tmp/eosio/eosio-wallet

start_keosd(){
    killall keosd 2>/dev/null
    rm -rf ${WALLET_DIR}
    mkdir ${WALLET_DIR}
    nohup keosd -d ${WALLET_DIR} 2>/dev/null &
}
start_keosd


create_wallet(){
    cleos wallet create --to-console
    cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
}
create_wallet

