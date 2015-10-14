
    $(document).ready(function() {
        $('.delete-notification').click (function(){
            var row = $(this).closest('.each_notification').get(0);
            $.post(this.href, {_method:'delete'}, null, "script");
            $(row).hide(500);
            return false;
        });
    });
