

$(document).ready(function() {
    toggleAttorneyType();
});

$('#ssn_field').hide();
$('#age').hide();
$('#date_of_birth_field').hide();

$('#contact_type').on('change', function() {
    var conceptName = $('#contact_type').find(":selected").text();
    if (conceptName == 'Defendant') {
        $('#date_of_birth_field').show();
        $('#ssn_field').show();
        $('#age').show();
        $('#attorney_type_field').hide();
    } else if (conceptName == 'Plaintiff') {
        $('#ssn_field').show();
        $('#date_of_birth_field').show();
        $('#age').show();
        $('#attorney_type_field').hide();
    }
    else if (conceptName == 'Attorney') {
        $('#attorney_type_field').show();
    } else {
        $('#ssn_field').hide();
        $('#date_of_birth_field').hide();
        $('#age').hide();
        $('#attorney_type_field').hide();
    }
});

function toggleAttorneyType(){
    var conceptName = $('#contact_type').find(":selected").text();
    if (conceptName != 'Attorney') {
        $('#attorney_type_field').hide();
    }
}

$(document).ready(function() {
    $('.phone').mask("(999) 999-9999");
});

$(function() {
  $('#company').tipsy({gravity: 's', fade: true});
});

$(document).ready(function() { $("select").select2(); });
