---
author: "organofcorti"
date: "8 May 2016"
---

This [R](http://r-project.org) script scrapes and flattens blockchain variable data from various APIs into a data.table and a .csv file. At the moment only the Blockchain.info and Kaiko.com APIs are included

# Before running script:
1. Make sure you enter your working directory at  
```R
setwd("/your/path/here")
```  
and preferred R repo in
```R
R_repo <- "http://your/R/repo/"
```


The output table will contain fields which depend on the API chosen.

##### Blockchain.info tables will contain:
"time" (unixtime, UTC), "height", "hash", "ver", "fee", "n_tx", "size", "script_hex", "tx_hash", "generationAddress", "addr_tag" and ”API"

An example of the output is here: [blockchain.info_data.csv](https://github.com/organofcorti/kaiko-blockchain-API-script/blob/master/blockchain.info_data.csv)


###### Use Sys.sleep() command if you need to slow down your request due to the request limiter, currently set to:
   * Requests in 8 Hours: 3 (Soft Limit = 30000, Hard Limit = 30500) 
   * Requests in 5 minutes: 3 (Soft Limit = 500, Hard Limit = 525) 

  
###### Check https://blockchain.info/api for up-to-date info, and https://blockchain.info/api/api_create_code if you want to avoid the request limiter altogether.


##### Kaiko.com tables will contain:
"time" (UTC),”height","hash","size","branch","reward","fees","value","difficulty","total_out","tx_hash","version","generationAddress","script_hex","API"


An example of the output is here: [api.kaiko.com_data.csv](https://github.com/organofcorti/kaiko-blockchain-API-script/blob/master/api.kaiko.com_data.csv)
<<<<<<< Updated upstream

###### Check http://docs.kaiko.com/ for more information.

##### Let me know if you want other APIs added

=======
>>>>>>> Stashed changes
