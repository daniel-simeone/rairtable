
delete <- function(ids, airtable_obj, rate = NULL){
  response <- httr::DELETE(sprintf("%s?%s", attr(airtable_obj, 'request_url'), ids),
                           config = httr::add_headers(
                             Authorization = paste("Bearer", get_airtable_api_key())
                           )
  )

  if (!httr::status_code(response) %in% c(200)){
    stop(paste0("Error in DELETE ", process_error(httr::status_code(response))), call. = FALSE)
  }

  if (!is.null(rate)) Sys.sleep(1 / rate) else Sys.sleep(.2)
}

vdelete <- Vectorize(delete, vectorize.args = "ids")
