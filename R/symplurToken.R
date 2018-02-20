#' Symplur API - Token
#'
#' @keywords token
#' @export
#'
symplurToken <- function(){
  Sys.setenv(TZ="UTC")
  token <- Sys.getenv('SYMPLUR_TOKEN')
  if (identical(token, "")) {
    if (identical(Sys.getenv('SYMPLUR_clientId'), "")) {
      SymplurClientId <- readline("What is your Symplur API clientId? ")
      Sys.setenv(SYMPLUR_clientId = SymplurClientId)
    }
    if (identical(Sys.getenv('SYMPLUR_clientSecret'), "")) {
      SymplurClientSecret <- readline("What is your Symplur API clientSecret? ")
      Sys.setenv(SYMPLUR_clientSecret = SymplurClientSecret)
    }
    config <- symplurConfig()
    baseUrl = config$baseUrl
    clientId = Sys.getenv('SYMPLUR_clientId')
    clientSecret = Sys.getenv('SYMPLUR_clientSecret')
    endpoint = paste(baseUrl, "oauth/token", sep="")
    secret <- jsonlite::base64_enc(paste(clientId, clientSecret, sep = ":"))
    req <- httr::POST(endpoint,
      httr::add_headers(
      "Authorization" = paste("Basic", gsub("\n", "", secret)),
      "Content-Type" = "application/x-www-form-urlencoded;charset=UTF-8"
      ),
      body = "grant_type=client_credentials"
    );
    httr::stop_for_status(req, "Authenticate with Symplur")
    token <- httr::content(req)$access_token
    Sys.setenv(SYMPLUR_TOKEN = token)
  }
  return(token)
}
