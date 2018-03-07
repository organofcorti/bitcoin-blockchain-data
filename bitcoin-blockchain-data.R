
#### set path
setwd("/your/path/here")

#### set your repo
#R_repo <- "http://cran.csiro.au/"
R_repo <- "http://your/R/repo/"

libs <- list("RJSONIO", "data.table", "pbapply", "plyr", "dplyr", "bit64")

invisible(lapply(libs, function(x){
        result <- library(x, logical.return=T, character.only =T)
        if(result == F) install.packages(x, repos=R_repo)
        library(x, character.only =T)
}))


source("blockchain_info_func.R")
source("blocktrail_func.R")


### used by flatten_list_func function to convert to ints and convert NULL to NA
int_null_func <- function(x){
	if(is.null(x)) return(NA)
	if(is.numeric(x)) return(as.integer64(x)) 
	if(is.logical(x)) return(x)
	# some APIs return integers as class character
	suppressWarnings(
		if(!is.na(as.integer64(x))) return(as.integer64(x)) 
		)
	return(x)
	}
				
### MY_API_KEY is the API key required by some sites (eg blocktrail.com)
### Choose the API you want to use as args in the function
### function will flatten json list into a data table
### 'sleep' arg uses Sys.sleep to create a pause between iterations (in seconds).

flatten_list_func <- function(MY_APIKEY, API=c("blockchain.info", "blocktrail.com", "api.kaiko.com"), sleep = 0, x){
		
			if(API == "blockchain.info") block_data_table <- cbind(blockchain_info_func(sleep=sleep, x), API= API)
			if(API == "blocktrail.com") block_data_table <- cbind(blocktrail_func(MY_APIKEY=MY_APIKEY, sleep=sleep, x), API= API)
			
			return(block_data_table)
	}


### Examples of use
### Note: converting to data.table here in case more than saving to .csv is required


### blockchain.info
API <- "blockchain.info"
sleep <- 1
block_heights_requested <- 411300:411350
data_dt <- rbindlist(pbsapply(block_heights_requested, function(x) flatten_list_func(MY_APIKEY=NULL, API=API, sleep=sleep, x), simplify=F))
csv_filename <- paste0(data_dt[1,API], "_", paste(range(data_dt$height), collapse="_"), "_data.csv")
write.csv(data_dt, csv_filename)

### blocktrail.com
# remember to set MY_APIKEY
API <- "blocktrail.com"
sleep <- 1
#MY_APIKEY <- "<my apikey>"
block_heights_requested <- 411300:411350
data_dt <- rbindlist(pbsapply(block_heights_requested, function(x) flatten_list_func(MY_APIKEY=MY_APIKEY, API=API, sleep=sleep, x), simplify=F))
csv_filename <- paste0(data_dt[1,API], "_", paste(range(data_dt$height), collapse="_"), "_data.csv")
write.csv(data_dt, csv_filename)


