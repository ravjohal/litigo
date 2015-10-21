$(document).ready(function() {
    $("#lead_select, td select").select2();
    $('#invoice_due_date').datetimepicker({
        pickTime: false,
        format: 'M/D/YYYY'
    });
});
