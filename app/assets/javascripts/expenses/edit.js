$(function() {
  $('#print').tipsy({gravity: 'n', fade: true});
  $('#delete').tipsy({gravity: 'n', fade: true});
  $('#accept').tipsy({gravity: 'ne', fade: true});
  $(".edit_expense select").select2({allowClear: true});
});
