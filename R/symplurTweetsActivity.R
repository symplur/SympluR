#' Symplur API - Tweets/Activity
#'
#' API endpoint documentation:
#' https://api.symplur.com/v1/docs#/Twitter_Analytics:_Tweets/get_twitter_analytics_tweets_activity
#' @param start Start time for period analyzed, read above API docs for more info.
#' @param end End time for period analyzed
#' @param databases The database(s) analyzed. Comma separate string if using more than one database.
#' @param interval Unit of time to use for periods. Supported values are "minutes", "hours", "days", "weeks", "months", and "years". You must choose an interval that results in 500 periods or less, based on your selected date range. If omitted, the system will try to guess an appropriate interval.
#' @keywords tweets activity
#' @export
#' @examples
#' LCSMDemoDataTweetsActivity <- symplurTweetsActivity(
#'     "09/01/2017",
#'     "09/08/2017",
#'     databases = "#LCSMDemoData",
#'     "days")
#' @import httr
#' @import jsonlite
#'
symplurTweetsActivity <- function(start = "09/01/2017", end = "09/08/2017", databases = "#LCSMDemoData", interval = "days"){
  endpoint = "twitter/analytics/tweets/activity"
  parameters = list(
    "start" = start,
    "end" = end,
    "databases" = databases,
    "interval" = interval
    )

  config <- symplurConfig()
  url <- paste(config$baseUrl, endpoint, sep="")
  req <- httr::GET(url, query = parameters, httr::add_headers(Authorization = paste("Bearer", symplurToken())))
  json <- httr::content(req, as = "text", encoding = "UTF-8")

  options(warn=-1)
  output <- fromJSON(json, flatten=TRUE)
  table <- as.data.frame(output)
  table <- cbind("tweet count" = 0, table, row.names = NULL)
  table["tweet count"] <- output$series$data
  drops <- c("series.name", "series.data", "request.start", "request.end")
  table <-  table[ , !(names(table) %in% drops)]
  options(warn=0)

  return(table)
}



#' Symplur API - Tweets/Activity Table
#'
#' Creates a dataframe from looping through queries.
#'
#' Example query dataframe:
#' \tabular{lll}{
#' database \tab start \tab end\cr
#' #BCSM \tab 01/01/2010 \tab 01/01/2018\cr
#' #LCSM \tab 01/01/2010 \tab 01/01/2018\cr
#' #BTSM \tab 01/01/2010 \tab 01/01/2018
#' }
#' @param query A dataframe with columns: database, start and end.
#' @keywords tweets activity table
#' @export
#' @examples
#' require(readr)
#' datasets <- read_csv(system.file("extdata", "datasets.csv", package = "SympluR", mustWork = TRUE))
#' LCSMDemoDataTweetsActivityTable <- symplurTweetsActivityTable(datasets)
#' @import plyr
#'
symplurTweetsActivityTable <- function(query = data.frame(database=character(),start=character(), end=character())){
  for (i in 1:nrow(query)) {
    database = as.character(query[i, "database"])
    start = as.character(query[i, "start"])
    end = as.character(query[i, "end"])

    message("Now analyzing: ", database)
    start.time <- Sys.time()
    data <- symplurTweetsActivity(start,end,database)
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
