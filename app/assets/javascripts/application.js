// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require activestorage
//= require jquery3
//= require popper
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require turbolinks
//= require clickable.js
//= require summernote/summernote-bs4
//= require summernote/summernote-cleaner

//= require ajax_modal.js
//= require descriptions.js
//= require deferred_images.js
//= require copy_to_clipboard.js


//$.fancybox.defaults.hash = false;

;(function () {
  var scrollPosition
  document.addEventListener('turbolinks:load', function () {
    if (scrollPosition) {
      window.scrollTo(0, scrollPosition[1]);
      scrollPosition = null
    }
  }, false)

  Turbolinks.reload = function () {
    scrollPosition = [window.scrollX, window.scrollY]
    Turbolinks.visit(window.location, { action: 'replace' })
  }
})()

function onTableRowClick(event, el) {
  if (event.target.nodeName == "A" || event.target.nodeName == "BUTTON") {
    return false;
  } else if ($(el).find("a.main-link:not([data-modal])").length) {
    Turbolinks.visit($(el).find(".main-link").attr("href"));
  }
}
