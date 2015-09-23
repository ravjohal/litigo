$(document).ready(function () {
    $('select').select2();
    var selected_contacts_ids_count = {};

    function addToSelected(id) {
        if (!selected_contacts_ids_count.hasOwnProperty(id)) selected_contacts_ids_count[id] = 0;
        selected_contacts_ids_count[id]++;
    }

    function removeFromSelected(id) {
        if (!selected_contacts_ids_count.hasOwnProperty(id)) selected_contacts_ids_count[id] = 0;
        selected_contacts_ids_count[id]--;
    }

    $('.contacts_select :selected').each(function (i, obj) {
        addToSelected($(obj).val());
    });
    $('.contacts_select').change(function (e) {
        if (e.hasOwnProperty('added')) {
            var contact_id = e.added.id;
            if (!selected_contacts_ids_count.hasOwnProperty(contact_id)) selected_contacts_ids_count[contact_id] = 0;
            if(selected_contacts_ids_count[contact_id] > 0) {
                alert('There is a contact on multiple roles, please confirm that is what you intended.')
            }
            addToSelected(contact_id);
        } else if (e.hasOwnProperty('removed')) {
            removeFromSelected(e.removed.id);
        }
    })
});
