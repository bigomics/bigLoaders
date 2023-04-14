function showSpinner(id, id_spinner) {
  $(id_spinner).show();
  $(id).css("visibility", "hidden");
}

function hideSpinner(id, id_spinner) {
  $(id_spinner).hide();
  $(id).css("visibility", "inherit");
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
