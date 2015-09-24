$(document).ready(function () {
    $(".modal-dialog td #case_select, .modal-dialog td #time_entry_aba_code").select2();
});
$('.charge_block input').change(function (e) {
    var time_entry_type = $(this).val().toLowerCase().replace(/ /g, '_');
    $('.rate-row').hide();
    $('.'+time_entry_type).show();
})
