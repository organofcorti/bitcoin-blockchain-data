
This [R](http://r-project.org) script downloads and flattens blockchain variable data from various APIs into a data.table and a .csv file. 


API functions available for:
* Blockchain.info
* Blocktrail.com
* Kaiko.com

# Before running script:
1. Make sure you enter your working directory at  
```R
setwd("/your/path/here")
```  
and preferred R repo in
```R
R_repo <- "http://your/R/repo/"
```

* The output table will contain fields which depend on the API chosen.
* All integers are 64 bit (using the bit64 library) in case you want to operate on the data before saving it. 
* Consider using the data.table library (as in the example) if you’re operating on a significant portion of blockchain history.


=====

##### Blockchain.info tables will contain:
"time" (unixtime,UTC),"height", "hash", "ver", "fee", "n_tx", "size", "script_hex", "tx_hash", "generationAddress", "addr_tag_link", "addr_tag","API"

An example of the output is here: [blockchain.info_data.csv](https://github.com/organofcorti/bitcoin-blockchain-data/blob/master/blockchain.info_411300_411350_data.csv)

###### Use Sys.sleep() command if you need to slow down your request due to the request limiter, currently set to:
   * Requests in 8 Hours: 3 (Soft Limit = 30000, Hard Limit = 30500) 
   * Requests in 5 minutes: 3 (Soft Limit = 500, Hard Limit = 525) 

  
###### Check https://blockchain.info/api for up-to-date info, and https://blockchain.info/api/api_create_code if you want to avoid the request limiter altogether.
=====

##### Blocktrail.com tables will contain:
"height","hash","block_time","difficulty","is_orphan","byte_size","transactions","value","miningpool_name","miningpool_url","miningpool_slug","total_input_value","total_output_value","total_fee","script_signature","generationAddress","API"

An example of the output is here: [blocktrail.com_411300_411350_data.csv](https://github.com/organofcorti/bitcoin-blockchain-data/blob/master/blocktrail.com_411300_411350_data.csv)

###### Check https://www.blocktrail.com/api/docs#api_block for more information.
=====

##### Kaiko.com tables will contain:
"hash", "fees", "value", "bits", "difficulty", "reward", "transactions_count", "size", "height", "timestamp (UTC)“, ”version", "total_out", "tx_hash", "generationAddress", "script_hex", "API"


An example of the output is here: [api.kaiko.com_411300_411350_data.csv](https://github.com/organofcorti/bitcoin-blockchain-data/blob/master/api.kaiko.com_411300_411350_data.csv)

###### Check http://docs.kaiko.com/ for more information.
=====


##### Let me know if you want other APIs added


