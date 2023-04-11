#' Add CSS and JS dependencies for the bigLoaders package
#'
#' @export
addBigLoaderDeps <- function() {
  htmltools::htmlDependency(
    name = "bigLoaders",
    version = as.character(utils::packageVersion("bigLoaders")),
    package = "bigLoaders",
    src = "www",
    script = "spinner.js",
    stylesheet = "spinner.css"
  )

}
