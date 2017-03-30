#' Creating a single data frame from a folder of similarly structured Excel spreadsheets
#'
#' Like Voltron-ing your Excel data
#' @param folder The folder in relation to your working directory where the Excel files exist. Default folder is the current working directory.
#' @param export File name to export csv file as, if wanted.
#' @keywords data appending
#' @export
#' @examples
#' bulk_csv(folder="data", export="combined_data.csv")

# This is the read.csv method using lapply

#bulk_excel <- function(folder="DEFAULTBULKCSV2017", export="filenamedefaultbulkcsv2017.xls"){
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



bulk_excel <- function(folder="DEFAULTBULKCSV2017", export="filenamedefaultbulkcsv2017.csv"){
  require(readxl)
  require(dplyr)

  if (folder=="DEFAULTBULKCSV2017" | folder=="") {
    folder <- getwd()
  } else {
    folder <- paste0(getwd(), "/", folder)
  }

  files = list.files(folder, pattern=c("*.xls", "*.xlsx"))

  files <- files[!grepl("~", substr(files, 1,1))]


  pb <- txtProgressBar(min = 0, max = length(files), style = 3)

  for (i in 1:length(files)) {
    file_x <- read_excel(paste0(folder, "/", files[i]))
    colnames(file_x) <- ifelse(is.na(colnames(file_x)), "", colnames(file_x))
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


