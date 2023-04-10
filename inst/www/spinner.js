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