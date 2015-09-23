
$("select").select2();
$('#contacts').on('cocoon:after-remove', function(e, insertedItem) {

});

$(function() {
  $('#remove').tipsy({gravity: 's', fade: true});
});

$(document).ready(function() {
    $('.phone').mask("(999) 999-9999");
});

