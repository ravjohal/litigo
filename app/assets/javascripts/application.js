// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require turbolinks
//= require fullcalendar
//= require gcal
//= require jquery-ui
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require d3/lib/d3.v3
//= require d3/topojson.v1.min
//= require d3/datamaps.usa.min
//= require d3/nv.d3
//= require d3/src/utils
//= require d3/src/models/axis
//= require d3/src/tooltip
//= require d3/src/interactiveLayer
//= require d3/src/models/legend
//= require d3/src/models/axis
//= require d3/src/models/scatter
//= require d3/src/models/stackedArea
//= require d3/src/models/stackedAreaChart
//= require d3/src/models/pie
//= require d3/src/models/pieChart
//= require select2
//= require lib/tag-it
//= require best_in_place
//= require jquery.purr
//= require hopscotch
//= require bootbox
//= require lib/jasny-bootstrap
//= require lib/jquery.collapsible
//= require lib/jquery.feedback_me
//= require lib/linq.min
//= require lib/sugar.min
//= require lib/tipr
//= require slick
//= require lib/welcome_tour
//= require moment
//= require bootstrap-datetimepicker
//= require maskedinput
//= require_tree .

var ready = function(){
    fm_options = {
        show_email: true,
        email_required: true,
        position: "right-bottom",

        name_placeholder: "",
        email_placeholder: "",
        message_placeholder: "Enter your comments here",

        name_required: true,
        message_required: true,

        show_asterisk_for_required: true,

        feedback_url: "send_feedback_clean",

        delayed_options: {
            delay_success_milliseconds: 3500,
            send_success : "Successfully Sent"
        }
    };
    if ($(".welcome-link").length !== 0) {
        fm.init(fm_options);
    }
};

$(document).ready(ready);
$(document).on('page:load', ready);
$(document).on('page:change', function (e) {
    if(e.currentTarget.location.pathname == "/insights") {
        $("#btnFilterSearch").click();
    }
});