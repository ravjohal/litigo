$(document).ready(function() { $("td select").select2({allowClear: true});
});
$('#case_case_type').on('change', function() {
    var conceptName = $('#case_case_type').find(":selected").text();
    if (conceptName == "Personal Injury") {
        $('#incident_date').show();
        $('#private_injury').show();
    } else {
        $('#incident_date').hide();
        $('#private_injury').hide();
    }
});
