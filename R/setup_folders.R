#' Command to set up an optimized folder structure for your project
#'
#' Folders that will be generated: `raw_output`, `output_data`, `rmd`, `docs`, `scripts`
#'
#' @export
#' @examples
#' setup_folders()


setup_folders <- function(){

  folder_names <- c("raw_data", "output_data", "rmd", "docs", "scripts")

  sapply(folder_names, dir.create)

}

