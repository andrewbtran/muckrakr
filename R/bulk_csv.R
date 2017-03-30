#' Creating a single data frame from a folder of similarly structure CSV spreadsheets
#'
#' Like Voltron-ing your data
#' @param folder The folder in relation to your working directory where the csv files exist. Default folder is the current working directory.
#' @param export File name to export csv file as, if wanted.
#' @keywords data appending
#' @import readr dplyr
#' @export
#' @examples
#' bulk_csv(folder="data", export="combined_data.csv")

bulk_csv <- function(folder="DEFAULTBULKCSV2017", export="filenamedefaultbulkcsv2017.csv"){
  if (folder=="DEFAULTBULKCSV2017" | folder=="") {
    folder <- getwd()
  }
  files = list.files(folder, pattern="*.csv")
  tbl = lapply(files, read_csv) %>% bind_rows()
  if (export!="filenamedefaultbulkcsv2017.csv" & export!="") {
    write_csv(tbl, export)
  }
}
