$(document).on "page:change", ->
  return unless $(".trip-sheets").length > 0


  $('.datepicker').datepicker(
    autoclose: true,
    autoSize: true,
    changeYear: true,
    changeMonth: true,
    dateFormat: "D, d M, yy"
  )


  $('#trips-calendar').fullCalendar(
    events: $('#trips-calendar').data('source')
    timezone: 'local'
    header: {
      left: 'prev,next today'
      center: 'title'
      right: 'month,basicWeek,basicDay'
      }
  );

  $('[data-behaviour~=search-trip-by-date]').on 'change', ->
    date = Date.parse($(this).val());
    $('#trips-calendar').fullCalendar('gotoDate', date);
    $('#trips-calendar').fullCalendar('changeView', 'basicDay')
