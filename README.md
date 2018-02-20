# SympluR
R package for analyzing data from the Healthcare Social Graph via access to the Symplur API.

## Get started
To install R package from GitHub:
```
library("devtools")
install_github('SympluR','symplur')
```

## Symplur API Credentials
To make us of the R package you need to have access to the Symplur API. Please [contact Symplur](https://www.symplur.com/contact/) if you are interested in gaining access.

You need the `clientId` and the `clientSecret` provided to you by Symplur. The R package will prompt you for this information during the first API call in your session. Simply paste in your credentials when asked.

## Documentation
Find the documentation in R for each function in this package.
```
?symplurSummary
?symplurSummaryTable
```

To learn more about each Symplur API endpoint used in this package and the accepted parameters please see the [Symplur API Documentation](https://api.symplur.com/v1/docs).
