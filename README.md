# eosio-test



debug配置程序参数 -e -p eosio -d /Users/song/tmp/eosio/data --config-dir /Users/song/tmp/eosio/config --plugin eosio::chain_api_plugin --plugin eosio::producer_plugin --plugin eosio::producer_api_plugin --contracts-console  --max-transaction-time 1000
注意:要同时有-e 和-p eosio才可以出块



cleos push action eosio setparams '{
  "params": {
      "max_block_net_usage": 1048576,
      "target_block_net_usage_pct": 1000,
      "max_transaction_net_usage": 524288,
      "base_per_transaction_net_usage": 12,
      "net_usage_leeway": 500,
      "context_free_discount_net_usage_num": 20,
      "context_free_discount_net_usage_den": 100,
      "max_block_cpu_usage": 200000,
      "target_block_cpu_usage_pct": 3000,
      "max_transaction_cpu_usage": 150000,
      "min_transaction_cpu_usage": 100,
      "max_transaction_lifetime": 3600,
      "deferred_trx_expiration_window": 600,
      "max_transaction_delay": 3888000,
      "max_inline_action_size": 4096,
      "max_inline_action_depth": 4,
      "max_authority_depth": 6
    }
}' -p eosio


v1/producer/get_greylist





### cleos 常用命令

api='https://api.eosstore.co'
alias cleos="cleos -u ${api}"

cleos get table eosio bigboss11111 userres

curl -X POST ${api}/v1/chain/get_account -d '{"account_name":"eosio"}'

res=`curl -s  -X POST  ${api}/v1/chain/get_account -d '{"account_name":"eosstorebest"}' `
echo $res |jq .ram_usage
echo $res |jq .ram_quota


cleos get table eosio eosio global
cleos get table eosio eosio global2




