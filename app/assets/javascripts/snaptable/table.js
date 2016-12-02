/* global $ */
"use strict";

/* Admin table */

function snapifyTable(snaptable) {

  var tableButtons = snaptable.find(".table_buttons"),
      editButton = tableButtons.find("a[class='edit']"),
      deleteButton = tableButtons.find("a[class='delete']"),
      showButton = tableButtons.find("a[class='show']"),
      path = window.location.pathname + "/";

  // add ajax to the pagination
  snaptable.on("click", ".pagination a", function() {
    $.getScript(this.href);
    return false;
  });

  // line clickable
  snaptable.on("click", "tbody tr", function(e) {
    var id = $(this).data("url") ;
    if ( typeof id !== "undefined" && !$(this).hasClass("selected") ) {
      snaptable.find("tr.selected").removeClass("selected");
      $(this).addClass("selected");
      deleteButton.add(editButton).add(showButton).addClass("on");
      editButton.attr("href", path + id + "/edit");
      deleteButton.attr("href", path + id);
      showButton.attr("href", path + id);
    }
  });

  // Double click
  if(editButton.length) {
    snaptable.on("dblclick", "tbody tr", function() {
      var id = $(this).data("url");
      if ( typeof id !== "undefined" ) {
        window.location = path + id + "/edit";
      }
    });
  }

}

function snapifyTables() {

  $(".snaptable").each(function() {
    snapifyTable($(this));
  })

}

$(document).on("ready turbolinks:load", function() {

  snapifyTables();

});
