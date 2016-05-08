---
author: "organofcorti"
date: "30 April 2016"
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

Blockchain.info tables will contain:
"time" (unixtime, UTC), "height", "hash", "ver", "fee", "n_tx", "size", "script_hex", "tx_hash", "generationAddress", "addr_tag" and ”API"

An example of the output is here: [api.kaiko.com_data.csv](https://github.com/organofcorti/kaiko-blockchain-API-script/blob/master/api.kaiko.com_data.csv)



Kaiko.com tables will contain:
"time" (UTC),”height","hash","size","branch","reward","fees","value","difficulty","total_out","tx_hash","version","generationAddress","script_hex","API"


An example of the output is here: [api.kaiko.com_data.csv](https://github.com/organofcorti/kaiko-blockchain-API-script/blob/master/api.kaiko.com_data.csv)

Check http://docs.kaiko.com/ for more information.


