#' Symplur API - Summary
#'
#' API endpoint documentation: https://api.symplur.com/v1/docs#/Twitter_Analytics:_Tweets/get_twitter_analytics_tweets_summary
#' @param start Start time for period analyzed, read above API docs for more info.
#' @param end End time for period analyzed
#' @param data The database(s) analyzed. A list.
#' @keywords summary
#' @export
#' @examples
#' LCSM <- symplurSummary("09/01/2017", "09/08/2017", list("databases[]" = "#LCSMDemoData"))
#' @import httr
#' @import jsonlite
#'
symplurSummary <- function(start = "09/01/2017", end = "09/08/2017", data = list("databases[]" = "#LCSMDemoData")){
  endpoint = "twitter/analytics/tweets/summary"
  parameters = list(
    "start" = start,
    "end" = end
    )

  queryParams <- c(parameters, data)
  config <- symplurConfig()
  url <- paste(config$baseUrl, endpoint, sep="")
  req <- httr::GET(url, query = queryParams, httr::add_headers(Authorization = paste("Bearer", symplurToken())))
  json <- httr::content(req, as = "text", encoding = "UTF-8")
  summary <- fromJSON(json, flatten=TRUE)

  return(summary)
}



#' Symplur API - Summary Table
#'
#' Creates a dataframe from looping through queries.
#'
#' Example query dataframe:
#' \tabular{lll}{
#' #BCSM \tab 01/01/2010 \tab 01/01/2018\cr
#' #LCSM \tab 01/01/2010 \tab 01/01/2018\cr
#' #BTSM \tab 01/01/2010 \tab 01/01/2018
#' }
#' @param query A dataframe with columns: database, start and end.
#' @keywords summary table
#' @export
#' @examples
#' CancerTagOntology <- symplurSummaryTable(CTOquery)
#' @import plyr
#'
symplurSummaryTable <- function(query = data.frame(database=character(),start=character(), end=character())){
  for (i in 1:nrow(query)) {
    database = as.character(query[i, "database"])
    start = as.character(query[i, "start"])
    end = as.character(query[i, "end"])

    message("Now analyzing: ", database)
    start.time <- Sys.time()
    data <- symplurSummary(start,end,list("databases[]" = database))
    end.time <- Sys.time()
    time.taken <- end.time - start.time
    message("Execution time: ", time.taken)

    if (i == 1){
      table <- as.data.frame(data)
    } else {
      table <- rbind.fill(table, as.data.frame(data))
    }
  }
  return(table)
}
