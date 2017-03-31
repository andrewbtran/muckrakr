#' Creating a single data frame from a folder of similarly structure CSV spreadsheets
#'
#' Like Voltron-ing your data. This package is based on readr, so passing on variables from read_csv will work in bulk_csv. These variables will apply to the import of each CSV sheet.
#' @param folder The folder in relation to your working directory where the csv files exist. Default folder is the current working directory.
#' @param export File name to export csv file as, if wanted.
#' @keywords data appending
#' @export
#' @examples
#' bulk_csv(folder="data", export="combined_data.csv")

# This is the read.csv method using lapply

#bulk_csv <- function(folder="DEFAULTBULKCSV2017", export="filenamedefaultbulkcsv2017.csv", ){
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

bulk_csv <- function(folder="DEFAULTBULKCSV2017", export="filenamedefaultbulkcsv2017.csv", col_names = TRUE, col_types = NULL,
                     locale = default_locale(), na = c("", "NA"), quoted_na = TRUE,
                     comment = "", trim_ws = TRUE, skip = 0, n_max = Inf,
                     guess_max = min(1000, n_max), progress = interactive()){
  require(readr)
  require(dplyr)

  col_names_f <- col_names
  col_types_f <- col_types
  locale_f <- locale
  na_f <- na
  quoted_na_f <- quoted_na
  comment_f <- comment
  trim_ws_f <- trim_ws
  skip_f <- skip
  n_max_f <- n_max
  guess_max_f <- guess_max
  progress_f <- progress

  if (folder=="DEFAULTBULKCSV2017" | folder=="") {
    folder <- getwd()
  } else {
    folder <- paste0(getwd(), "/", folder)
  }

  files = list.files(folder, pattern="*.csv")

  pb <- txtProgressBar(min = 0, max = length(files), style = 3)

  for (i in 1:length(files)) {
    file_x <- read_csv(paste0(folder, "/", files[i]), , col_names = col_names_f, col_types = col_types_f,
                       locale = local_f, na = na_f, quoted_na = quoted_na_f,
                       comment = comment_f, trim_ws = trim_ws_f, skip = skip_f, n_max = n_max_f,
                       guess_max = guess_max_f, progress = progress_f)
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

