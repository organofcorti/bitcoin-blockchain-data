library(RJSONIO)
library(data.table)
library(pbapply)
library(plyr)
library(bit64)

MY_APIKEY <- "6debaf0ebd4c9081795fe38716df550c46ab06fb"

blocktrail_func <- function(MY_APIKEY=MY_APIKEY, sleep=0, x){

			# x can be either block height or a block hash
			# convert all to lowercase
			# if x is block height needs to be int

			if(is.character(x)) {
				x <-	tolower(x)} else {
				x <- as.integer64(x)}

			# API url
			block_url	<- "https://api.blocktrail.com/v1/btc/block/"
			APIkey		<- paste0("?api_key=", MY_APIKEY)

			# get json
			block_data_list_0	<- fromJSON(paste0(block_url, x, APIkey))
			tx_data_list_0	<- fromJSON(paste0(block_url, x, "/transactions", APIkey))
			
			# make numerics into 64 bit ints
			block_data_list	<- llply(block_data_list_0, int_null_func)
			tx_data_list	<-  tx_data_list_0$data[[1]] 

			# all of the block and generation tx results:
			block_stats		<- data.frame(block_data_list, stringsAsFactors=F)
			tx_stats		<- data.frame(llply(tx_data_list[!names(tx_data_list_0$data[[1]]) %in% c("inputs","outputs")], int_null_func),
										stringsAsFactors=F)
										
			tx_inputs		<- ldply(tx_data_list $inputs, function(x) data.frame(llply(x, int_null_func), stringsAsFactors=F))
			tx_outputs		<- ldply(tx_data_list $outputs, function(x) data.frame(llply(x, int_null_func), stringsAsFactors=F))				
				
			# to keep one row per block, return "Multiple" if more than one generation address
			if(nrow(tx_outputs) > 1) {generationAddress <- "Multiple"} else {generationAddress <- tx_outputs$address}

			# keep only subset of results (can be edited if other fields are required)
			data_frame <- cbind(	
						block_stats[, c("height", "hash", "block_time", "difficulty", "is_orphan", "byte_size", "transactions", 
						"value", "miningpool_name", "miningpool_url", "miningpool_slug")],
						tx_stats[, c("total_input_value", "total_output_value", "total_fee")],
						script_signature = tx_inputs[, "script_signature"],
						generationAddress = generationAddress
						)
			
                                Sys.sleep(sleep)

                                return(data_frame)
		}



