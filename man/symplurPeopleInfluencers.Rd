% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/symplurPeopleInfluencers.R
\name{symplurPeopleInfluencers}
\alias{symplurPeopleInfluencers}
\title{Symplur API - People/Influencers}
\usage{
symplurPeopleInfluencers(start = "09/01/2017", end = "09/08/2017",
  databases = "#LCSMDemoData", limit = 100, metric = "mentions")
}
\arguments{
\item{start}{Start time for period analyzed, read above API docs for more info.}

\item{end}{End time for period analyzed}

\item{databases}{The database(s) analyzed. Comma separate string if using more than one database.}

\item{limit}{Maximum number of retweets to return. Must be positive integer. Default is 10. Max is 500.}

\item{metric}{Comma-separated list of one or more metrics to calculate. Results will be sorted by the first metric in the list. Supported metrics are "hsg_score", "mentions", "retweets", "tweets", "impressions", and "replies".}
}
\description{
API endpoint documentation:
https://api.symplur.com/v1/docs#/Twitter_Analytics:_People/get_twitter_analytics_people_influencers
}
\examples{
LCSMDemoDataPeopleInfluencers <- symplurPeopleInfluencers(
    "09/01/2017",
    "09/08/2017",
    databases = "#LCSMDemoData",
    50)
}
\keyword{influencers}
\keyword{people}
