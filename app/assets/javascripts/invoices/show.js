$(function () {
    $('#print').tipsy({gravity: 'n', fade: true});
    $('#delete').tipsy({gravity: 'n', fade: true});
    $('#add_payment').find('span').tipsy({gravity: 'n', fade: true});
    $('#issue_invoice').click(function () {
        $('#invoice_status').val('unpaid');
        $('#hidden_form').submit();
    });
});
