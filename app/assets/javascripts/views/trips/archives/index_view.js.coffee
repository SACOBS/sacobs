window.Views.Trips ||= {}
window.Views.Trips.Archives ||= {}
class Views.Trips.Archives.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    $('#archived_trip_search').on 'ajax:success', (evt, data, status, xhr) ->
      $('#archived_trips').html(data)

  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    $('#archived_trip_search').off 'ajax:success'
