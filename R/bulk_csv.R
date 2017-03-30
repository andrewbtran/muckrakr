#' Creating a single data frame from a folder of similarly structure CSV spreadsheets
#'
#' Like Voltron-ing your data
#' @param folder The folder in relation to your working directory where the csv files exist. Default folder is the current working directory.
#' @param export File name to export csv file as, if wanted.
#' @keywords data appending
#' @export
#' @examples
#' bulk_csv(folder="data", export="combined_data.csv")

# This is the read.csv method using lapply

#bulk_csv <- function(folder="DEFAULTBULKCSV2017", export="filenamedefaultbulkcsv2017.csv"){
#  require(dplyr)
#
#  if (folder=="DEFAULTBULKCSV2017" | folder=="") {
#    folder <- getwd()
#  } else {
#    folder <- paste0(getwd(), "/", folder)
#  }
#  files = list.files(folder, pattern="*.csv")
#  tbl <- lapply(paste0(folder, "/", files), read.csv) %>% bind_rows()
#  return(tbl)
#  if (export!="filenamedefaultbulkcsv2017.csv" & export!="") {
#    write_csv(tbl, export)
#  }
#}

# this is the readr version but it loops and has a progress bar

bulk_csv <- function(folder="DEFAULTBULKCSV2017", export="filenamedefaultbulkcsv2017.csv"){
  require(readr)
  require(dplyr)

  if (folder=="DEFAULTBULKCSV2017" | folder=="") {
    folder <- getwd()
  } else {
    folder <- paste0(getwd(), "/", folder)
  }

  files = list.files(folder, pattern="*.csv")

  pb <- txtProgressBar(min = 0, max = length(files), style = 3)

  for (i in 1:length(files)) {
    file_x <- read_csv(paste0(folder, "/", files[i]))
    if (i ==1) {
      all_files <- file_x
    } else {
      all_files <- rbind(all_files, file_x)
    }
    setTxtProgressBar(pb, i)

  }

  if (export!="filenamedefaultbulkcsv2017.csv" & export!="") {
    write_csv(all_files, export)
  }
  return(all_files)

}

