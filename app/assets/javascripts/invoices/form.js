$(document).ready(function () {

    var case_id = null;

    (function () {
        case_id = $('#invoice_case_id').val();
    })();

    function makeCaseDataRequest(url, selector, data) {
        if (typeof data === "undefined") {
            data = {};
        }
        case_id = $('#invoice_case_id').val();
        makeDataRequest('/cases/' + case_id + '/' + url, selector, data);
    }

    function makeDataRequest(url, selector, data) {
        if (typeof data === "undefined") {
            data = {};
        }
        $.ajax({url: url, data: data}).done(function (data) {
            $(selector).html(data);
        });
    }

    function updateInvoiceSummAmount() {
        var expenses_ids = $('#invoice_expenses_ids').val().toString().split(',');
        var services_ids = $('#invoice_time_entries_ids').val().toString().split(',');

        $.ajax({url: '/invoice_sum', data: {expenses_ids: expenses_ids, services_ids: services_ids}, dataType: 'json'})
            .done(function (data) {
                $('#total_amount').html(data.html);
                $('#invoice_amount').val(data.sum);
            });
    }

    $("form select").select2();

    $('#invoice_case_id').change(function () {
        makeCaseDataRequest('case_contacts', '#invoice_contact_id');
    });

    $('#add_services').click(function () {
        if (case_id > 0) {
            var ids = $('#invoice_time_entries_ids').val().toString().split(',');
            makeCaseDataRequest('case_services', '#modal-window', {
                ids: ids,
                number: $('#invoice_number').val()
            });
        } else {
            return false;
        }
    });
    $('#add_expenses').click(function () {
        if (case_id > 0) {
            var ids = $('#invoice_expenses_ids').val().toString().split(',');
            makeCaseDataRequest('case_expenses', '#modal-window', {
                ids: ids,
                number: $('#invoice_number').val()
            });
        } else {
            return false;
        }
    });

    $(document).on('click', '#confirm_add_services', function () {
        var ids = $('input[name="selected_service[]"]:checked').map(function () {
            return $(this).val();
        });
        ids = $.makeArray(ids);
        $('#invoice_time_entries_ids').val(ids.join(','));
        makeDataRequest('/invoice_services', '#services_table', {ids: ids});
        $('#modal-window').modal('hide');
        updateInvoiceSummAmount();
    });
    $(document).on('click', '#confirm_add_expenses', function () {
        var ids = $('input[name="selected_expense[]"]:checked').map(function () {
            return $(this).val();
        });
        ids = $.makeArray(ids);
        $('#invoice_expenses_ids').val(ids.join(','));
        makeDataRequest('/invoice_expenses', '#expenses_table', {ids: ids});
        $('#modal-window').modal('hide');
        updateInvoiceSummAmount();
    });

    $('#save_draft').click(function () {
        $('#invoice_status').val('draft');
        $('#submit_form').click();
        return false;
    });

    $('#issue_invoice').click(function () {
        $('#invoice_status').val('unpaid');
        $('#submit_form').click();
        return false;
    });
});