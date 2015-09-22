
$(document).ready(function() {
    $("#note_select, td select").select2();
    $('#note_add_task').change(function (e) {
        if($(this).is(':checked')) {
            $('.task_field').show();
        } else {
            $('.task_field').hide();
        }
    })
});
$('#note_select').change(function (e) {
    $('.case_alert').show();
});
