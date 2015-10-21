$(document).ready(function () {
    $('table').on('mouseenter mouseleave', 'tr', function () {
        if ($('.status-circle').length > 0) {
            $('.status-circle').tipr({
                'speed': 500,
                'mode': 'top'
            });
        }
    });
});