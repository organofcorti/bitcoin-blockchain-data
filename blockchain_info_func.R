
blockchain_info_func <- function(sleep = 0, x){

				url1 <- "https://blockchain.info/block-height/"
				url2 <- "?format=json"

				# get json, flatten
				data_list_0 <- fromJSON(paste0(url1, x, url2))
        		data_list_1 <- llply(data_list_0$blocks, function(x) llply(x, function(y) y[[1]]))
        		data_table_0 <- data.table(ldply(data_list_1, function(x) data.frame(x)))
        		
 				block_data_table <- data.table(t(do.call(rbind, data_list_1[[1]][which(names(data_list_1[[1]]) != "tx")])))
 				tx_data_table0 <- ldply(data_list_1[[1]]$tx$out, function(x) data.frame(x))
  				tx_data_table <- data.table(tx_data_table0[1,])
	
				# "script_hex" can be converted to ASCII for coinbase signature
 				script_hex <- data_list_1[[1]]$tx$inputs[[1]]$script
 								
 				# if more than one generation address, return tx.out.addr as "multiple"
 				if(nrow(tx_data_table0) > 1) 	{
 					tx_data_table$addr <- "Multiple"
 				}

        		# if no tx.addr tag, add a dummy var to keep table flat
        		if(!any(colnames(tx_data_table0) == "addr_tag")) {
                tx_data_table[, addr_tag := "Unknown"]
        		}
               					
        		# ignore orphans
        		data_table_1 <- cbind(
        		block_data_table[main_chain==TRUE, list(time, height, hash, ver, fee,  n_tx, size)],
        		tx_data_table[, list(script_hex = script_hex, tx_hash = data_list_1[[1]]$tx$hash, generationAddress = addr, addr_tag)]
        		)
        
        		Sys.sleep(sleep)
        
        		return(data_table_1)       
		}