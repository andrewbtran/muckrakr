#' Downloading packages that are needed but aren't yet on the system
#'
#' @param packages Array of packages found on CRAN
#' @param gh_packages Array of packages found on Github
#' @keywords Downloading packages that are needed but aren't yet on the system
#' @export
#' @examples
#' packagr(packages=c("tidyverse", "rtweet"), gh_packages=c("abtran/muckrakr"))

packagr <- function(packages=c("tidyverse"), gh_packages=c("abtran/muckrakr")){
  require(devtools)

  check <- sapply(packages,require,warn.conflicts = TRUE,character.only = TRUE)
  if(any(!check)){
    pkgs.missing <- packages[!check]
    install.packages(pkgs.missing)
    check <- sapply(pkgs.missing,require,warn.conflicts = TRUE,character.only = TRUE)
  }

  if (gh_packages!="abtran/muckrakr") {
   packages <- gsub(".*\\/", "", gh_packages)
   gh_packages_df <- data.frame(gh_packages)
   check <- sapply(packages,require,warn.conflicts = TRUE,character.only = TRUE)
   if(any(!check)){
    pkgs.missing <- packages[!check]

    gh_packages_df <- filter(gh_packages_df, grepl(paste(pkgs.missing, collapse="|"), gh_packages))
    devtools::install_github(gh_packages_df$gh_packages)

    check <- sapply(packages,require,warn.conflicts = TRUE,character.only = TRUE)

  }
  }
}


