#' Archive nwsldata
#'
#' @param release_name Name of the release
#'
#' @note Mod'd from Tan Ho
#' @export
archive_nwsldata <- function(release_name){

  cli::cli_alert_info("Archiving {release_name}")
  temp_dir <- tempdir(check = TRUE)

  # * Download all files
  piggyback::pb_download(dest = temp_dir,
                         repo = "nwslR/nwsldata",
                         tag = release_name)

  # * Create new release
  try({
    piggyback::pb_new_release(
      repo = "nwslR/nwsldata-data-archives",
      tag = glue::glue("archive-{release_name}-{as.character(Sys.Date())}")
    )
  },
  silent = TRUE)

  # * Write all files to a new release
  file_list <- list.files(file.path(temp_dir))

  Sys.sleep(5)

  piggyback::pb_upload(
    file = list.files(file.path(temp_dir), full.names = TRUE),
    repo = "nwslR/nwsldata-data-archives",
    tag = glue::glue("archive-{release_name}-{as.character(Sys.Date())}")
  )

  cli::cli_alert_success("Successfully archived {release_name}")

  unlink(temp_dir, recursive = TRUE)
  return(invisible(NULL))
}

