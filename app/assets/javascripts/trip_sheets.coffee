$(document).on "page:change", ->
  return unless $(".trip-sheets").length > 0

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
    $calendar = $('#trips-calendar')
    if(this.value != '' || this.value != this.defaultValue)
      date = Date.parse($(this).val());
      $calendar.fullCalendar('gotoDate', date);
      $calendar.fullCalendar('changeView', 'basicDay')
    else
      $calendar.fullCalendar('changeView', 'month')
