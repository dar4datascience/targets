dir_create <- function(x) {
  if (!file.exists(x)) {
    dir.create(x, showWarnings = FALSE, recursive = TRUE)
  }
  invisible()
}

dir_create_runtime <- function(x) {
  if (is.null(tar_runtime$file_exist)) {
    dir_create(x)
    return()
  }
  if (!all(counter_exist_names(tar_runtime$file_exist, x))) {
    dir.create(x, showWarnings = FALSE, recursive = TRUE)
    counter_set_names(tar_runtime$file_exist, x)
  }
  invisible()
}

file_exists_runtime <- function(x) {
  if (is.null(tar_runtime$file_exist)) {
    return(file.exists(x))
  }
  out <- counter_exist_names(tar_runtime$file_exist, x)
  out[!out] <- file.exists(x[!out])
  out
}

file_info_runtime <- function(x) {
  if_any(
    !is.null(tar_runtime$file_info) &&
      !is.null(tar_runtime$file_info_exist) &&
      all(counter_exist_names(tar_runtime$file_info_exist, x)),
    tar_runtime$file_info[x,, drop = FALSE], # nolint
    file.info(x, extra_cols = FALSE)
  )
}