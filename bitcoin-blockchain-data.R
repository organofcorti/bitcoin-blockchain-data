
#### set path
setwd("/your/path/here")
setwd("/Users/andy/blockchain_github/bitcoin-blockchain-data")

#### set your repo
#R_repo <- "http://cran.csiro.au/"
R_repo <- "http://your/R/repo/"

libs <- list("RJSONIO", "data.table", "pbapply", "plyr")

invisible(lapply(libs, function(x){
        result <- library(x, logical.return=T, character.only =T)
        if(result == F) install.packages(x, repos=R_repo)
        library(x, character.only =T)
}))


source("blockchain_info_func.R")
source("kaiko_func.R")


### chose which API you want to use as args in the function
### function will flatten json list into a data table
### 'sleep' arg uses Sys.sleep to create a pause between iterations (in seconds).


flatten_list_func <- function(API=c("blockchain.info", "api.kaiko.com"), sleep = 0, x){

	# make block height int
	x <- as.integer(x)
	
	### blockchain.info
	###			
			if(API == "blockchain.info") block_data_table <- cbind(blockchain_info_func(sleep=sleep, x), API= API)
			if(API == "api.kaiko.com") block_data_table <- cbind(kaiko_func(sleep=sleep, x), API= API)
			
			return(block_data_table)
	}


### Example of use:
### blockchain.info
API <- "blockchain.info"
sleep <- 1
block_heights_requested <- 410200:410260
data_dt <- rbindlist(pbsapply(block_heights_requested, function(x) flatten_list_func(API=API, sleep=sleep, x), simplify=F))

write.csv(data_dt, paste0(data_dt[1,API], "_data.csv"))


### kaiko
API <- "api.kaiko.com"
sleep <- 1
blocks_requested <- 410200:410260
data_dt <- rbindlist(pbsapply(block_heights_requested, function(x) flatten_list_func(API=API, sleep=sleep, x), simplify=F))

write.csv(data_dt, paste0(data_dt[1,API], "_data.csv"))

