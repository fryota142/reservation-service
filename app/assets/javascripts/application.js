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

$(function () {
  $(document).on('turbolinks:load', function () {

    create_event = function(start){
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/events/create",
        data: {
          start_time: start.toISOString(),
        }
      }).done(function(data){
        alert("登録しました!");
      }).fail(function(data){
        alert("登録できませんでした。");
      });
    };

    if ($('#fp_calendar').length) {
      function eventCalendar() {
          return $('#fp_calendar').fullCalendar({
          });
      };
      function clearCalendar() {
          $('#fp_calendar').html('');
      };

      $(document).on('turbolinks:load', function () {
          eventCalendar();
      });
      $(document).on('turbolinks:before-cache', clearCalendar);

      $('#fp_calendar').fullCalendar({
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
        },
        eventColor: '#63ceef',
        minTime: "10:00:00",
        maxTime: "18:00:00",
        defaultTimedEventDuration: '00:30:00',
        slotDuration: '00:30:00',
        snapDuration: '00:30:00',
        navLinks: true,
        selectable: true,
        selectHelper: true,
        select: function(start, end, view) {
          if(view.name != 'month') {
            var eventData;
            if (window.confirm('この時間に予約枠を作成しますか?')) {
              eventData = {
                start: start
              };
              $('#fp_calendar').fullCalendar('renderEvent', eventData, true);
              $('#fp_calendar').fullCalendar('unselect');
              create_event(start);
            }
          };
        },
        events: '/events.json',
        eventClick: function(info) {
          window.location.href = ('/reservations/' + info.id);
        },
      });
    }

    if ($('#user_calendar').length) {
      function eventCalendar() {
          return $('#user_calendar').fullCalendar({
          });
      };
      function clearCalendar() {
          $('#user_calendar').html('');
      };

      $(document).on('turbolinks:load', function () {
          eventCalendar();
      });
      $(document).on('turbolinks:before-cache', clearCalendar);
      $('#user_calendar').fullCalendar({
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
        },
        eventColor: '#63ceef',
        minTime: "10:00:00",
        maxTime: "18:00:00",
        defaultTimedEventDuration: '00:30:00',
        slotDuration: '00:30:00',
        snapDuration: '00:30:00',
        navLinks: true,
        dayClick: function(date, jsEvent, view) {
          if(view.name == 'month' || view.name == 'agendaWeek') {
            $('#user_calendar').fullCalendar('changeView', 'agendaDay');
            $('#user_calendar').fullCalendar('gotoDate', date);
          }
        },
        events: '/events.json',
        eventClick: function(info) {
          window.location.href = ('/reservations/' + info.id);
        },
      });
    }
  });
});
