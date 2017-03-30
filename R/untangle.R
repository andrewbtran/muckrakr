#' Disentangling a complex variable
#'
#' We are occassionally faced with a data set variable that contains multiple pieces of information. Multiple pieces of information are stored in this variable. In this case these pieces are delineated by a comma or colon. As is, the variable is not useful.
#' The *untangle* function can be used to create a set of dummy codes from this variable that will be more useful. This results in a new dataset with dummy codes
#' @param data The name of the dataframe you
#' @param x Column to untangle
#' @param pattern Special characters that separate the variables in the column
#' @param verbose TRUE or FALSE
#' @keywords data wrangling
#' @export
#' @examples
#' untangle(data=test_data, x="charges", pattern="[,:]", verbose=TRUE)

untangle <- function(data, x, pattern, verbose=FALSE){
  require(stringr)

  variable <- str_to_lower(data[[x]])

  # obtain list of unique codes
  code_matrix <- str_split(variable, pattern, simplify=TRUE)
  code_vector <- as.character(code_matrix)
  code_vector <- str_trim(code_vector)
  code_vector <- unique(code_vector[code_vector != ""])
  if(verbose) cat("[Unique Codes] ", code_vector, "\n", sep="\n")

  # create dummy codes matrix
  nobs <- nrow(data)
  ncodes <- length(code_vector)
  dummy_codes <- matrix(rep(NA, times=nobs*ncodes), ncol=ncodes)

  # add 1/0 codes
  for(i in 1:ncodes){
    dummy_codes[,i] <- ifelse(str_detect(variable, code_vector[i]), 1, 0)
  }

  # add dummy code names
  dummy_codes <- as.data.frame(dummy_codes)
  codenames <- str_replace_all(code_vector, " ", "_")
  names(dummy_codes) <- codenames

  # add to data frame
  newdata <- cbind(data, dummy_codes)

}
