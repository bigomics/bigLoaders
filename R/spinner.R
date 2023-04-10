library(shiny)

#' Add a spinner to a Shiny output
#'
#' @param output A Shiny output object
#'
#' @return A modified Shiny output object with a spinner
#' @export
useSpinner <- function(output) {
  tagList(
    tags$head(
      tags$style(HTML("
        .spinner {
          border: 8px solid #f3f3f3;
          border-top: 8px solid #3498db;
          border-radius: 50%;
          width: 60px;
          height: 60px;
          animation: spin 2s linear infinite;
        }

        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }
      ")),
      tags$script(HTML(sprintf("
      function showSpinner() {
        $('.spinner').show();
        $('#%s').hide();
      }

      function hideSpinner() {
        $('.spinner').hide();
        $('#%s').show();
      }

      $(document).on('shiny:outputinvalidated', function(event) {
        if (event.name === '%s') {
          showSpinner();
        }
      });

      $(document).on('shiny:value', function(event) {
        if (event.name === '%s') {
          hideSpinner();
        }
      });
    ", output$attribs$id,
       output$attribs$id,
       output$attribs$id,
       output$attribs$id)))
    ),
    # div(
    #   # style = "position: relative; display: flex; justify-content: center; align-items: center; width: 100%; height: 400px;",
    #   style = "position: relative; display: flex; justify-content: center; align-items: center; width: 100%;",
    #   div(
    #     id = paste0(output$attribs$id, "-spinner"),
    #     class = "spinner",
    #     style = "position: absolute; z-index: 1;"
    #   ),
    #   output
    # )
    div(
      id = paste0(output$attribs$id, "-spinner"),
      class = "spinner",
      style = "position: absolute; z-index: 1; top: calc(50% - 30px); left: calc(50% - 30px);"
    ),
    output
  )
}
