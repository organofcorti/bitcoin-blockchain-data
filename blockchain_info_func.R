

blockchain_info_func <- function( sleep = 0, x){
			# blockheight needs to be 64 bit int
			if(is.character(x)) {
				height <-	tolower(x)} else {
				height <- as.integer64(x)}

			url1 <- "https://blockchain.info/block-height/"
			url2 <- "?format=json"

			# get json
			data_list_0 <- fromJSON(paste0(url1, height, url2))
				
			# data for block 				
 			block_data_df <- data_list_0$blocks[[1]][!names(data_list_0$blocks[[1]]) %in% "tx"] %>%
						llply(int_null_func) %>%
						data.frame(stringsAsFactors=F)

			# first input and any outputs
			tx_data_list <-  data_list_0$blocks[[1]]$tx[[1]][!names(data_list_0$blocks[[1]]$tx[[1]]) %in% c("inputs", "out")] %>%
							llply(int_null_func)

			tx_inputs_list <- data_list_0$blocks[[1]]$tx[[1]]$inputs[[1]] %>%
							llply(int_null_func)
			tx_out_df <-  ldply(data_list_0$blocks[[1]]$tx[[1]]$out, function(x)data.frame(llply(x, int_null_func), stringsAsFactors=F)) 				

			addr_tag_link <-  tx_out_df$addr_tag_link
			addr_tag <-  tx_out_df$addr_tag
			generationAddress <- tx_out_df$addr						
				
			# to keep one row per block, return "Multiple" if more than one generation address
			if(nrow(tx_out_df) > 1) {
				generationAddress <- "Multiple"
				addr_tag_link <- NA
				addr_tag <- NA 
			} 
				
			# if addr_tag unknown field is missing rather than NULL 
			# replace with NA
        		if(is.null(addr_tag)) addr_tag <- NA
        		if(is.null(addr_tag_link)) addr_tag_link <- NA
				
  
				
			# "script_hex" can be converted to ASCII for coinbase signature
 			script_hex <- tx_inputs_list$script

       		# ignore orphans and bind to other data
			# look at tx_data_list, tx_inputs_list and tx_out_df
			# to see if there are other variables you might want to keep.

        		data_frame <- cbind(
        		block_data_df[block_data_df$main_chain==TRUE, c("time", "height", "hash", "ver", "fee", "n_tx", "size")],
        		script_hex = script_hex, tx_hash = tx_data_list$hash, 
			generationAddress = generationAddress , addr_tag_link=addr_tag_link, addr_tag = addr_tag
			)
        
        		Sys.sleep(sleep)
        
        		return(data_frame)   
        		
		}

