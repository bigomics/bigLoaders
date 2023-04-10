function showSpinner(id, id_spinner) {
  $(id_spinner).show();
  $(id).hide();
}

function hideSpinner(id, id_spinner) {
  $(id_spinner).hide();
  $(id).show();
}

$(document).on('shiny:outputinvalidated', function(event) {
  showSpinner("#"+event.name, "#"+event.name+"-spinner")
});

$(document).on('shiny:value', function(event) {
  hideSpinner("#"+event.name, "#"+event.name+"-spinner")
});

$(document).on('shiny:error', function(event) {
  hideSpinner("#"+event.name, "#"+event.name+"-spinner")
});
