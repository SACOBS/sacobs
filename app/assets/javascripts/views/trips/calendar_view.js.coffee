window.Views.Trips ||= {}
class Views.Trips.CalendarView extends Views.ApplicationView
  render: ->
    super()
    $('#calendar').fullCalendar(
      defaultView: 'basicWeek'
      events: 'calendar.json'
      dayClick: (date, jsEvent, view) ->
        $.ajax(
          url: $('#calendar').data('new-trip-url')
          type: 'POST'
          data: {trip: {start_date: date}}
          dataType: 'Script'
        )
        return
      eventClick: (event) ->
        if event.url
          $.get event.url, (data) ->
            $( "#calendar" ).effect("slide", {  "direction" : "left",  "mode" : "hide"}, 1500)
            $("#trip").html(data)
            $( "#trip" ).effect("slide", {  "direction" : "right",  "mode" : "show"}, 1500)


          #window.open(event.url)
          return false
    )


  cleanup: ->
    super()
    $('#calendar').off()
