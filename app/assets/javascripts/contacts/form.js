$(document).ready(function () {
    $("td select").select2();
});
$("#new_contact").bind("ajax:error", function (evt, xhr, status, error) {
    var error_text = "";
    var error_list = $.parseJSON(xhr.responseText);
    $.each(error_list, function (key, value) {
//      if(key == 'similar') {
//        error_text += value.join(', ') + "</br>";
//        $('input#contact_sure').val(true);
//      } else {
        error_text = error_text + key + ": " + value.join(', ') + "</br>";
//      }
    });
    $('.alert').remove();
    $('body').append("<div class='alert alert-danger'><button type='button' class='close' data-dismiss='alert'>&#215;</button>" + error_text + "</div>");
});
$("#new_contact").bind("ajax:success", function (e, data, status, xhr) {
    $('#modal-window').modal('hide');
    $('.alert').remove();
    $('body').append("<div class='alert alert-success'><button type='button' class='close' data-dismiss='alert'>&#215;</button>Contact was successfully created.</div>");
    var tr = $('.table').DataTable().row.add([
        "<a href='/contacts/" + data.id + "'>" + data.last_name + " " + data.first_name + "</a>",
        data.type,
        data.email,
        data.phone_number
    ]).draw();
});
$('#ssn_field').hide();
$('#age').hide();
$('#company').hide();
$('#website').hide();
$('#company_field').show();
$('#date_of_birth_field').hide();
$('#contact_type').on('change', function () {
    var conceptName = $('#contact_type').find(":selected").text();
    if (conceptName == 'Defendant') {
        $('#date_of_birth_field').show();
        $('#ssn_field').show();
        $('#age').show();
        $('#attorney_type_field').hide();
        $('#website').hide();
        $('#email').show();
    } else if (conceptName == 'Plaintiff') {
        $('#ssn_field').show();
        $('#date_of_birth_field').show();
        $('#age').show();
        $('#attorney_type_field').hide();
        $('#website').hide();
        $('#email').show();
    }

    else if (conceptName == 'Company') {
        $('#company_field').hide();
        $('#company').show();
        $('#first_name').hide();
        $('#last_name').hide();
        $('#website').show();
        $('#email').hide();
        $('#ssn_field').hide();
        $('#date_of_birth_field').hide();
        $('#age').hide();
        $('#new_co').hide();
    } else {
        $('#ssn_field').hide();
        $('#date_of_birth_field').hide();
        $('#age').hide();
        $('#attorney_type_field').hide();
        $('#company_field').show();
        $('#company').hide();
        $('#first_name').show();
        $('#last_name').show();
        $('#website').hide();
        $('#email').show();
    }
});

$(document).ready(function () {
    $('#contact_phone').mask("(999) 999-9999");
    $('#contact_phone_ext').mask("(999) 999-9999");
    $('#contact_fax').mask("(999) 999-9999");
    $('#contact_fax_number').mask("(999) 999-9999");
});

$(function () {
    $('#comp').tipsy({gravity: 's', fade: true});
});
