// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require moment
//= require fullcalendar
//= require fullcalendar/lang/ja
//= require rails-ujs
//= require popper
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).ready(function() {
    $('#calendar').fullCalendar({
      events: '/events.json',
      eventColor: '#63ceef',
    //   editable: true
    });
});

// $(document).ready(function() {
//     $('#calendar').fullCalendar({
//       events: 
//       [
//           {
//               start: "2020-02-26 07:37:31",
//               end: "2020-02-26 08:00:31"
//           }
//       ],
//     });
// });