#' Add CSS and JS dependencies for the bigLoaders package
#'
#' @export
addBigLoaderDeps <- function() {
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "bigLoaders/spinner.css"),
    tags$script(type = "text/javascript", src = "bigLoaders/spinner.js")
  )
}