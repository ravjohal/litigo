
$(document).ready(function() {
    $("#task_select, select").select2({allowClear: true});
    $('#task_add_event').change(function (e) {
        if ($(this).is(":checked")){
            $('.google-calendar-row').show();
        } else {
            $('.google-calendar-row').hide();
            $('#task_google_calendar_id').val('');
            $('#task_google_calendar_id').select2('val', '');
        }
    })
});

$(function() {
  $('#back').tipsy({gravity: 'n', fade: true});
});

