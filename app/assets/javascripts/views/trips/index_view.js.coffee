window.Views.Trips ||= {}
class Views.Trips.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    $('#trip_search').on 'ajax:success', (evt, data, status, xhr) ->
      $('#trips').html(data)

  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    $('#trip_search').off 'ajax:success'
