library(shiny)

#' Add a spinner to a Shiny output
#'
#' @param output A Shiny output object
#'
#' @return A modified Shiny output object with a spinner
#' @export
useSpinner <- function(output) {

  if(inherits(output, "list")){
    id <- output[[1]]$attribs$id
  } else if (inherits(output, "shiny.tag")) {
    id <- output$attribs$id
  }

  tagList(
    div(
      id = paste0(id, "-spinner"),
      class = "spinner",
      style = "position: absolute; z-index: 1; top: calc(50% - 24px); left: calc(50% - 24px);"
    ),
    output
  )
}
