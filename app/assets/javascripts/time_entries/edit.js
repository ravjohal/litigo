$(function() {
  $('#print').tipsy({gravity: 'n', fade: true});
  $('#delete').tipsy({gravity: 'n', fade: true});
  $('#accept').tipsy({gravity: 'ne', fade: true});
  $(".time_entry-table td #time_entry_case_id, .time_entry-table td #time_entry_aba_code").select2({allowClear: true});
});
