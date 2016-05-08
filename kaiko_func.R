
kaiko_func <- function(sleep=0, x){

				url1 <- "https://api.kaiko.com/v1/blocks/"
				txurl <- "https://api.kaiko.com/v1/transactions/"

				# get json, flatten
				block_data_list_0 <- fromJSON(paste0(url1, x))
        		tx_data_list_0 <- fromJSON(paste0(txurl, block_data_list_0$transactions[[1]]$hash))
        
        		# script_hex can be converted to ASCII for coinbase signature
        		script_hex <- tx_data_list_0$inputs[[1]]$script_hex
        
        		# note - only records the first address if there are more than one generation addresses
        		# else labels them 'multiple'
        		
        		generationAddress <- tx_data_list_0$outputs[[1]]$addresses
        		if(length(generationAddress) > 1) generationAddress <- "Multiple"
        
        		data_list_1 <- llply(block_data_list_0,  function(y) y[[1]])
        		data_table_0 <- data.table(do.call(cbind, llply(data_list_1, function(x) x[[1]])))
        		data_table_1 <- data_table_0[ , list(time=timestamp, height, hash, size, branch, reward, fees, 
                                value, difficulty, total_out, tx_hash = transactions, version,
                                generationAddress=generationAddress, script_hex=script_hex)]
                      
    
        		Sys.sleep(sleep)
        	
        		return(data_table_1)
			}