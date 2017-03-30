#' Take a screenshot of a tweet
#'
#' Quick screenshot of a tweet based on a link
#' @param link the URL of the tweet
#' @param filename the base name of the image you want to save. Default will be user's twitter handle.
#' @param folder the folder you want to save the screenshot to
#' @keywords twitter screenshot
#' @export
#' @examples
#' tweet_cap(link="https://twitter.com/memeprovider/status/833888807959289856", folder="images")

tweet_cap <- function(link="", filename="NOTHINGTWEET_CAP", folder="DEFAULTTWEETCAP"){
  if(!require(devtools)){
    install.packages("devtools")
    library(devtools)
  }
  if(!require(webshot)){
    devtools::install_github("wch/webshot")
    library(webshot)
  }

  if (folder=="DEFAULTTWEETCAP") {
    folder=getwd()
  } else {
    folder <- paste0(getwd(), "/", folder)
  }

  if (length(link)==1) {
    link = link
    username <- gsub("https://twitter.com/", "", link)
    username <- gsub("/.*","",username, fixed=F)
    if (filename=="NOTHINGTWEET_CAP") {
      pre_name <- username
    } else {
      pre_name <- filename
    }
    id_num <- gsub(".*/", "", link)
    image_name <- paste0(pre_name, id_num, ".png")
    webshot(link, paste0(folder, "/", image_name), selector=c(".permalink-inner", ".permalink-tweet-container"))

  }

  if (length(link)>1) {
    for (i in length(link)){
    link_i = link[i]
    username <- gsub("https://twitter.com/", "", link_i)
    username <- gsub("/.*","",username, fixed=F)
    if (filename=="NOTHINGTWEET_CAP") {
      pre_name <- username
    } else {
      pre_name <- filename
    }
    id_num <- gsub(".*/", "", link_i)
    image_name <- paste0(pre_name, id_num, ".png")
    webshot(link, paste0(folder, "/", image_name), selector=c(".permalink-inner", ".permalink-tweet-container"))
    }
  }


}
