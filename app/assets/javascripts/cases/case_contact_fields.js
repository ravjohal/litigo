$(document).ready(function() {
    
      $('#case_contacts_').on('cocoon:before-insert', function() {
          
      })
      .on('cocoon:after-insert', function(e, insertedItem) {
             $('#contact_prompt').select2();
             $('#role_prompt').select2();
      })
      .on("cocoon:before-remove", function() {

      })
      .on("cocoon:after-remove", function() {
        /* e.g. recalculate order of child items */
      });

});