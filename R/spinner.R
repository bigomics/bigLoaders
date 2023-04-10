library(shiny)

#' Add a spinner to a Shiny output
#'
#' @param output A Shiny output object
#'
#' @return A modified Shiny output object with a spinner
#' @export
useSpinner <- function(output) {
  outputId <- output$attribs$id
  ns <- NS(outputId)
  
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
        function showSpinner(id, ns) {
          var fullId = ns ? ns + '-' + id : id;
          $('#' + fullId + '-spinner').show();
          $('#' + fullId).hide();
        }

        function hideSpinner(id, ns) {
          var fullId = ns ? ns + '-' + id : id;
          $('#' + fullId + '-spinner').hide();
          $('#' + fullId).show();
        }

        $(document).on('shiny:outputinvalidated', function(event) {
          var bindingName = event.binding.bindingName;
          if (bindingName === 'shiny.plotOutputBinding' || bindingName === 'shiny.htmlOutputBinding') {
            showSpinner(event.name, '%s');
          }
        });

        $(document).on('shiny:value', function(event) {
          var bindingName = event.binding.bindingName;
          if (bindingName === 'shiny.plotOutputBinding' || bindingName === 'shiny.htmlOutputBinding') {
            hideSpinner(event.name, '%s');
          }
        });
      ", ns))
      )),
    div(
      style = "position: relative; display: flex; justify-content: center; align-items: center;",
      div(
        id = paste0(ns, "-", outputId, "-spinner"),
        class = "spinner",
        style = "position: absolute; z-index: 1; display: none;"
      ),
      output
    )
  )
}
