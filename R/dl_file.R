#' Downloads file from URL if file doesn't exist in set folder
#'
#' @param folder The folder in relation to your working directory where the file should exist. Default folder is `data`.
#' @param link The link to where the file exists
#' @keywords file checking and downloading
#' @export
#' @examples
#' dl_file(folder="data", link="https://website.com/data/bostonpayroll2013.csv")

dl_file <- function(folder="data", link="filenamedefaultbulkcsv2017.csv"){

  file_name <- gsub(".*\\/", "", link)
  file_folder <- paste0(folder, "/", file_name)

  if (!file.exists(file_folder)) {

    dir.create(folder, showWarnings = F)
    download.file(
      link,
      file_folder)
    print("File download complete")
  } else {
    print("File already exists")
  }

}




