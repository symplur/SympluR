# SympluR
[![DOI](https://zenodo.org/badge/122243873.svg)](https://zenodo.org/badge/latestdoi/122243873)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version-last-release/SympluR)](https://cran.r-project.org/package=SympluR)
[![Build Status](https://travis-ci.org/symplur/SympluR.svg?branch=master)](https://travis-ci.org/symplur/SympluR)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/HealthCatalystSLC/healthcareai-r/blob/master/LICENSE)


**[SympluR](https://CRAN.R-project.org/package=SympluR)** is a [R](https://www.r-project.org) package for analyzing data from the Healthcare Social Graph via access to the [Symplur API](https://api.symplur.com/v1/docs).


## Get started
Install R package from CRAN:
```
install.packages("SympluR")
library(SympluR)
```

For latest development version, install the package from GitHub:

```
library("devtools")
install_github('symplur/SympluR')
library(SympluR)
```

## Symplur API Credentials
To make us of this R package you need to have access to the Symplur API. The package comes with demo credentials that allow you to access the demo dataset `#LCSMDemoData`. This dataset is a 4-week snapshot of the conversations from [#LCSM](https://www.symplur.com/healthcare-hashtags/lcsm/) (Lung Cancer Social Media) from 08/16/2017 to 09/15/2017.

To access any other datasets, please [contact Symplur](https://www.symplur.com/contact/) for further details.

The R package will prompt you for your credentials during the first API call in your R session. Paste in your credentials when asked, or if you just want to try out the demo data then hit enter without entering anything.

## Documentation
Find the documentation in R for each function in this package. Example:

`?symplurSummary`

To learn more about each Symplur API endpoint used in this package and the accepted parameters please see the [Symplur API Documentation](https://api.symplur.com/v1/docs).

## Example Usage
### Summary

The `symplurSummary()` function will create a list with statistics of the database and the time span selected. The stats includes tweets, mentions, impressions, users, retweets, replies, urls_shared, etc.

`LCSM <- symplurSummary("09/01/2017", "09/08/2017", list("databases[]" = "#LCSMDemoData"))`

### Summary Table
The `symplurSummaryTable()` function will create a data frame with summary statistics of all databases and time spans defined in an existing data frame.
First create in a spreadsheet columns 'database', 'start' and 'end'. Add rows according to your query needs, then export as a CSV-file. Example table:

| database      | start      | end        |
|---------------|------------|------------|
| #LCSMDemoData | 09/01/2017 | 09/06/2017 |
| #LCSMDemoData | 09/06/2017 | 09/13/2017 |
| #LCSMDemoData | 09/13/2017 | 09/19/2017 |

Load that CSV-file into R as a data frame:

`library(readr)`

`LCSMquery <- read_csv(file.choose())`

Now we're ready to run the analysis:

`LCSManalysis <- symplurSummaryTable(LCSMquery)`


## Credits
Thank you to [Professor Larry Chu, MD](https://twitter.com/larrychu) at [Stanford University School of Medicine](https://medicinex.stanford.edu) for the idea of the SympluR R package.
