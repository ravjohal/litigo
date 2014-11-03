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
//= require jquery.datetimepicker
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
//= require best_in_place
//= require jquery.purr
//= require hopscotch
//= require jasny-bootstrap
//= require jquery.collapsible.js
//= require jquery.feedback_me
//= require linq.min
//= require sugar.min
//= require tipr
//= require welcome_tour
//= require_tree .


$(document).ready(function () {

    // $(window).on('hashchange', function(e){
    //     console.log("hola" + e);
    // });
    // console.log("weeeee" );

    //set up some minimal options for the feedback_me plugin
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

        custom_params: {
            csrf: "my_secret_token",
            user_id: "john_doe",
            feedback_type: "clean_complex"
        },
        delayed_options: {
            delay_success_milliseconds: 3500,
            send_success : "Sent successfully :) , now go ahead and star/watch the project"
        }
    };

        //init feedback_me plugin

// every page has class welcome-link on the page somewhere when the USER is Logged IN
// when not logged in the class does not exsist
    if ($(".welcome-link").length !== 0) {
       fm.init(fm_options);

      }
});

$(document).on('page:change', function (e) {
    if(e.currentTarget.location.pathname == "/insights") {
        $("#btnFilterSearch").click();
    }
});

// var default_options = {
//     feedback_url: "",
//     position: "left-top",
//     jQueryUI: false,
//     bootstrap: false,
//     show_email: false,
//     show_radio_button_list: false,
//     close_on_click_outisde: true,
//     name_label: "Name",
//     email_label: "Email",
//     message_label: "Message",
//     radio_button_list_labels: ["1", "2", "3", "4", "5"],
//     radio_button_list_title: "How would you rate my site?",
//     name_placeholder: "",
//     email_placeholder: "",
//     message_placeholder: "",
//     name_required: false,
//     email_required: false,
//     message_required: false,
//     radio_button_list_required: false,
//     show_asterisk_for_required: false,
//     submit_label: "Send",
//     title_label: "Feedback",
//     trigger_label: "Feedback",
//     custom_params: {},
//     iframe_url : undefined,
//     show_form: true,
//     custom_html: "",
//     delayed_close : true,
//     delayed_options : {
//         delay_success_milliseconds : 2000,
//         delay_fail_milliseconds : 2000,
//         sending : "Sending...",
//         send_fail : "Sending failed.",
//         send_success : "Feedack sent.",
//         fail_color : undefined,
//         success_color : undefined
//     }
// };


