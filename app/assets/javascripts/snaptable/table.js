/* global $ */
"use strict";

/* Admin table */

/* Admin table */

function snapifyTable(snaptable) {

  var tableButtons = snaptable.querySelector(".table_buttons"),
      editButton = tableButtons.querySelector("a.edit"),
      deleteButton = tableButtons.querySelector("a.delete"),
      showButton = tableButtons.querySelector("a.show"),
      path = window.location.pathname + "/",
      urlParams = new URLSearchParams(location.search),
      token = urlParams.get('token');
  
  var paramsStr = (token ? ("?token=" + token) : "")

  // line clickable
  snaptable.querySelector("tbody").addEventListener("click", function(e) {
    var target = e.target.parentElement; // td is clicked, tr is the direct parent
    var id = target.dataset.url;
    if (typeof id !== "undefined" && !target.classList.contains("selected")) {
      // change selected row
      var selected = snaptable.querySelector("tr.selected");
      if (selected) {
        snaptable.querySelector("tr.selected").classList.remove("selected");
      }
      target.classList.add("selected");
      // update the buttons
      if (showButton) {
        showButton.classList.add("on");
        showButton.setAttribute("href", path + id + paramsStr);
      }
      if (editButton) {
        editButton.classList.add("on");
        editButton.setAttribute("href", path + id + "/edit" + paramsStr);
      }
      if (deleteButton) {
        deleteButton.classList.add("on");
        deleteButton.setAttribute("href", path + id + paramsStr);
      }      
    }
  });

  if(editButton) {
    snaptable.querySelector("tbody").addEventListener("dblclick", function(e) {
      var target = e.target.parentElement; // td is clicked, tr is the direct parent
      var id = target.dataset.url;
      if ( typeof id !== "undefined" ) {
        window.location = path + id + "/edit" + paramsStr;
      }
    });
  }

}

function snapifyTables() {

  document.querySelectorAll(".snaptable").forEach(function(table) {
    snapifyTable(table);
  })

}

document.addEventListener("ready", snapifyTables);
document.addEventListener("turbolinks:load", snapifyTables);