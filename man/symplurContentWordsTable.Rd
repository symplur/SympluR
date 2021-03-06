% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/symplurContentWords.R
\name{symplurContentWordsTable}
\alias{symplurContentWordsTable}
\title{Symplur API - Content/Words Table}
\usage{
symplurContentWordsTable(query = data.frame(database = character(), start =
  character(), end = character()))
}
\arguments{
\item{query}{A dataframe with columns: database, start and end.}
}
\description{
Creates a dataframe from looping through queries.
}
\details{
Example query dataframe:
\tabular{lll}{
database \tab start \tab end\cr
#BCSM \tab 01/01/2010 \tab 01/01/2018\cr
#LCSM \tab 01/01/2010 \tab 01/01/2018\cr
#BTSM \tab 01/01/2010 \tab 01/01/2018
}
}
\examples{
require(readr)
datasets <- read_csv(system.file("extdata", "datasets.csv", package = "SympluR", mustWork = TRUE))
LCSMDemoDataContentWordsTable <- symplurContentWordsTable(datasets)
}
\keyword{content}
\keyword{table}
\keyword{words}
