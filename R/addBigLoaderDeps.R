#' Add CSS and JS dependencies for the bigLoaders package
#'
#' @export
addBigLoaderDeps <- function() {
  # files <- system.file("www",  package = "bigLoaders")
  # tags$head(
  #   tags$link(rel = "stylesheet",
  #             type = "text/css",
  #             href = paste0(files, "/spinner.css")),
  #   tags$script(type = "text/javascript",
  #               src = paste0(files, "/spinner.js"))
  # )
  htmltools::htmlDependency(
    name = "bigLoaders",
    version = as.character(utils::packageVersion("bigLoaders")),
    package = "bigLoaders",
    src = "www",
    script = "spinner.js",
    stylesheet = "spinner.css"
  )

}
