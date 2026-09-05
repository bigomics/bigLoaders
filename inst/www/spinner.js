function showSpinner(id, id_spinner) {
  $(id_spinner).show();
  $(id).css("visibility", "hidden");
}

function hideSpinner(id, id_spinner) {
  $(id_spinner).hide();
  $(id).css("visibility", "inherit");
}

// Widgets that build their own DOM in the browser after Shiny hands them
// their value. For these, 'shiny:value' is not the end of the wait.
function isClientDrawnWidget(el) {
  return el.classList.contains('plotly') ||
    el.classList.contains('js-plotly-plot') ||
    el.classList.contains('iheatmapr');
}

function hasPainted(el) {
  return !!el.querySelector('svg, canvas');
}

// ~10s at 60fps. A widget that never paints (empty data, a render error
// swallowed by the library) must not leave the spinner running forever.
var SPINNER_MAX_FRAMES = 600;

function hideSpinnerWhenPainted(id, id_spinner) {
  var el = document.getElementById(id);
  if (!el) {
    hideSpinner("#" + id, "#" + id_spinner);
    return;
  }
  var frames = 0;
  (function wait() {
    if (hasPainted(el) || ++frames > SPINNER_MAX_FRAMES) {
      hideSpinner("#" + id, "#" + id_spinner);
      return;
    }
    window.requestAnimationFrame(wait);
  })();
}

$(document).on('shiny:outputinvalidated', function(event) {
  showSpinner("#"+event.name, "#"+event.name+"-spinner")
});

$(document).on('shiny:value', function(event) {
  var el = document.getElementById(event.name);

  // 'shiny:value' fires when the value reaches the browser, which for a
  // client-drawn widget is before it draws anything -- plotly.js and
  // iheatmapr build their SVG from that value. Hiding the spinner here
  // leaves the container blank for the whole draw, which for a large
  // scatter or heatmap is the slow part. Keep it up until the widget has
  // actually painted. Everything else (tables, HTML, server-rendered plot
  // images) is complete at this point and hides immediately, as before.
  if (el && isClientDrawnWidget(el) && !hasPainted(el)) {
    hideSpinnerWhenPainted(event.name, event.name+"-spinner");
    return;
  }

  hideSpinner("#"+event.name, "#"+event.name+"-spinner")
});

$(document).on('shiny:error', function(event) {
  hideSpinner("#"+event.name, "#"+event.name+"-spinner")
});
