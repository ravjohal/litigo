$(document).ready(function () {
    $('.namespace_row').click(function (e) {
        if (!$('.get_calendars').is(e.target) && !$(e.target).hasClass('delete')){
            var id = $(this).data('id');
            if(id != undefined) {
                window.location.href = "/namespaces/"+id;
            }
        }
    });
})