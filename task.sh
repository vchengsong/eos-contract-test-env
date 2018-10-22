#!/usr/bin/env bash

. init.sh

set -x

import_key(){
    cleos wallet import --private-key $1
}

new_keys(){
    str=`cleos create key --to-console`
    pri_key=`echo $str | cut -d' ' -f 3`
    pub_key=`echo $str | cut -d' ' -f 6`
}

# usage: create_account account_name
create_account(){
    new_keys && cleos create account eosio $1 $pub_key -p eosio
    import_key $pri_key
}

steps(){
    # step 1: set contract eosio.bios
    cleos set contract eosio ${CONTRACTS_DIR}/eosio.bios -p eosio

    # step 2: create system accounts
    sleep 1
    for account in eosio.aaa eosio.bpay eosio.msig eosio.names eosio.ram eosio.ramfee eosio.saving eosio.stake eosio.token eosio.vpay
    do
        echo -e "\n creating $account \n";
        cleos create account eosio ${account} EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV -p eosio -x 1000
        sleep .2
    done

    # step 3: set contract
    echo step 3
    cleos set contract eosio.token ${CONTRACTS_DIR}/eosio.token -p eosio.token
    cleos set contract eosio.msig ${CONTRACTS_DIR}/eosio.msig -p eosio.msig

    # step 4: create and issue token
    echo step 4
    cleos push action eosio.token create '["eosio", "10000000000.0000 EOS"]' -p eosio.token
    cleos push action eosio.token issue '["eosio",  "1000000000.0000 EOS", "cryptokylin"]' -p eosio

    # setp 5: setting privileged account for eosio.msig
#    cleos push action eosio setpriv '{"account": "eosio.msig", "is_priv": 1}' -p eosio

    # step 6: set contract eosio.system
    cleos set contract eosio ${CONTRACTS_DIR}/eosio.system -x 1000 -p eosio

    cleos push action eosio init '[0, "4,EOS"]' -p eosio

}
steps

sleep .2
create_eosfirstacnt(){
    echo "create account."
    new_keys
    cleos system newaccount \
         --stake-net "100.0000 EOS" --stake-cpu "100.0000 EOS" --buy-ram "100.0000 EOS" \
         eosio eosfirstacnt $pub_key $pub_key -p eosio --transfer
    cleos transfer eosio eosfirstacnt "10000.0000 EOS"
    import_key $pri_key
}
create_eosfirstacnt

#cleos push action eosio newaccount '{"creator":"eosio","name":"eosstore1111","owner":{"threshold":1,"keys":[{"key":"EOS6yuxPfeaDrAxgHCh6H4jT2kgGvuy11hPgfEPksa4SwxGr3ZC4d","weight":1}],"accounts":[],"waits":[]},"active":{"threshold":1,"keys":[{"key":"EOS6yuxPfeaDrAxgHCh6H4jT2kgGvuy11hPgfEPksa4SwxGr3ZC4d","weight":1}],"accounts":[],"waits":[]}}' -p  eosio

create_one(){
    new_keys
    cleos system newaccount \
     --stake-net "1.0000 EOS" --stake-cpu "1.0000 EOS" --buy-ram "1.0000 EOS" \
     eosfirstacnt eosstoreff$1 $pub_key $pub_key -p eosfirstacnt
}

for i in 1a 1b 1c 1d 1e 1f 1g 1h 1i; do create_one ${i}; done

cleos push action eosio namelist '["actor_blacklist", "insert", ["eosstoreff1a","eosstoreff1b","eosstoreff1c"]]'  -p eosio

#cleos get table eosio eosstoreff1a userres
#cleos get table eosio eosio minguar

cleos get account eosstoreff1a
cleos push action eosio setminguar '[1,1,1]'   -p eosio


hallo(){

cleos push action eosio setlists '{
  "params": {
      "actor_blacklist":["111","222","333","444","555","aaa","bbb"],
      "contract_blacklist":["111","222"],
      "resource_greylist":["111"]
    }
}' -p eosio


cleos push action eosio setlists '{
  "params": {
      "actor_blacklist":[],
      "contract_blacklist":[],
      "resource_greylist":["111","222"]
    }
}' -p eosio



cleos push action eosio setlists '{
  "params": {
      "actor_blacklist": [
        "111",
        "222",
        "2221"
      ],
      "contract_blacklist": [
        "111",
        "222",
        "2221"
      ],
      "resource_greylist": [
        "111",
        "222"
      ]
    }
}' -p eosio




cleos get table eosio eosio lists


cleos push action eosio setpriv '{"account": "eosio.msig", "is_priv": 1}' -p eosio

cleos get table eosio eosio cntlrcfg



cleos push action eosio setcontcfg '{
  "params": {
      "a": 101
    }
}' -p eosio

}























