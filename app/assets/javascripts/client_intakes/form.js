$(document).ready(function() {
    $("#lead_select, td select").select2();
    $('#lead_phone').mask("(999) 999-9999");
});
$("#phone_book").hide();
$("select").bind("change", function() {
    if ($(this).val() == "Phone book") {
        $("#phone_book").show();
    }
    else {
        $("#phone_book").hide();
    }
});
