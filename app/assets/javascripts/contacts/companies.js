$(document).ready(function() {
  $('#new_modal').click(function(event){
    $("#modal-window").html("<%= escape_javascript(render 'contacts/form', new_contact: @companies_a ) %>");
  });
  <%= render :partial => 'datatable.js', :locals => { :sort_column => 0, :sort_order => 'asc'} %>
});

