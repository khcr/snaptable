/* Admin table */

$(document).on("ready page:load", function() {
  
  var tableButtons = $('.table_buttons'),
      editButton = tableButtons.find('a[class="edit"]'),
      deleteButton = tableButtons.find('a[class="delete"]'),
      path = window.location.pathname + '/';
      table = $("#admin_table");

  // add ajax to the pagination
  table.on("click", ".pagination a", function() {
    $.getScript(this.href);
    return false;
  });

  // line clickable
  table.on("click", "tbody tr", function(e) {
    var id = $(this).data('url') ;
    if ( typeof id !== 'undefined' && !$(this).hasClass('selected') ) {
      $('tr.selected').removeClass('selected');
      $(this).addClass('selected');
      deleteButton.add(editButton).addClass("on");
      editButton.attr('href', path + id + '/edit');
      deleteButton.attr('href', path + id);
    }
  });

  // Double click
  table.on("dblclick", "tbody tr", function() {
    var id = $(this).data('url');
    if ( typeof id !== 'undefined' ) {
      window.location = path + id + '/edit';
    }
  });

});