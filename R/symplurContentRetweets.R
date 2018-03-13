#' Symplur API - Content/Retweets
#'
#' API endpoint documentation:
#' https://api.symplur.com/v1/docs#/Twitter_Analytics:_Content/get_twitter_analytics_content_retweets
#' @param start Start time for period analyzed, read above API docs for more info.
#' @param end End time for period analyzed
#' @param databases The database(s) analyzed. Comma separate string if using more than one database.
#' @param limit Maximum number of retweets to return. Must be positive integer. Default is 10. Max is 500.
#' @keywords content retweets
#' @export
#' @examples
#' LCSMDemoDataContentRetweets <- symplurContentRetweets(
#'     "09/01/2017",
#'     "09/08/2017",
#'     databases = "#LCSMDemoData",
#'     50)
#' @import httr
#' @import jsonlite
#'
symplurContentRetweets <- function(start = "09/01/2017", end = "09/08/2017", databases = "#LCSMDemoData", limit = 100){
  endpoint = "twitter/analytics/content/retweets"
  parameters = list(
    "start" = start,
    "end" = end,
    "databases" = databases,
    "limit" = limit
    )

  config <- symplurConfig()
  url <- paste(config$baseUrl, endpoint, sep="")
  req <- httr::GET(url, query = parameters, httr::add_headers(Authorization = paste("Bearer", symplurToken())))
  json <- httr::content(req, as = "text", encoding = "UTF-8")

  output <- fromJSON(json, flatten=TRUE)
  table <- as.data.frame(output)
  drops <- c("tweets.tweet.media")
  table <-  table[ , !(names(table) %in% drops)]
  for (i in 1:nrow(table)) {
      if (is.null(table$tweets.tweet.user.stakeholder_categories[i][[1]][["id"]])) {
          table$tweets.tweet.user.stakeholder_categories[i] = "NA"
      } else {
          table$tweets.tweet.user.stakeholder_categories[i] = paste(sapply(table$tweets.tweet.user.stakeholder_categories[i], `[[`, 2), collapse=', ')
      }
  }
  return(table)
}



#' Symplur API - Content/Retweets Table
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
#' @keywords content retweets table
#' @export
#' @examples
#' require(readr)
#' datasets <- read_csv(system.file("extdata", "datasets.csv", package = "SympluR", mustWork = TRUE))
#' LCSMDemoDataContentRetweetsTable <- symplurContentRetweetsTable(datasets)
#' @import plyr
#'
symplurContentRetweetsTable <- function(query = data.frame(database=character(),start=character(), end=character())){
  for (i in 1:nrow(query)) {
    database = as.character(query[i, "database"])
    start = as.character(query[i, "start"])
    end = as.character(query[i, "end"])

    message("Now analyzing: ", database)
    start.time <- Sys.time()
    data <- symplurContentRetweets(start,end,database)
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
