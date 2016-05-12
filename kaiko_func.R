
kaiko_func <- function(sleep=0, x){

			# blockheight needs to be 64 bit int
			if(is.character(x)) {
				height <-	tolower(x)} else {
				height <- as.integer64(x)}

			url1 <- "https://api.kaiko.com/v1/blocks/"
			txurl <- "https://api.kaiko.com/v1/transactions/"

			# get json
			block_data_list_0 <- fromJSON(paste0(url1, height))
        		tx_data_list_0 <- fromJSON(paste0(txurl, block_data_list_0$transactions[[1]]$hash))
 
			# make numerics into 64 bit ints
			block_data_list	<- llply(block_data_list_0[names(block_data_list_0) != "transactions"], int_null_func)
			tx_data_list	<- llply(tx_data_list_0[!names(tx_data_list_0) %in% c("inputs", "outputs")], int_null_func)
       
			# flatten to data.frames
			block_data_df <- data.frame(block_data_list)
			tx_data_df <- data.frame(tx_data_list)
			tx_out_df <-  ldply(tx_data_list_0$outputs, function(x)data.frame(llply(x, int_null_func), stringsAsFactors=F)) 				

        		# script_hex can be converted to ASCII for coinbase signature
        		script_hex <- tx_data_list_0$inputs[[1]]$script_hex
        		
			# transaction hash for generation tx
			tx_hash <- block_data_list_0$transactions[[1]]$hash

        		# note - only records the first address if there are more than one generation addresses
        		# else labels them 'multiple'       		
        		generationAddress <- tx_out_df$addresses
        		if(length(generationAddress) > 1) generationAddress <- "Multiple"
        
			data_frame <- cbind(block_data_df[block_data_df$branch=="main", 
					c("hash", "fees", "value", "bits", "difficulty", "reward", 
					"transactions_count", "size", "height","timestamp","version","total_out")],
					tx_hash = tx_hash, generationAddress =generationAddress , script_hex=script_hex)

        		Sys.sleep(sleep)
        	
        		return(data_frame)
			}

