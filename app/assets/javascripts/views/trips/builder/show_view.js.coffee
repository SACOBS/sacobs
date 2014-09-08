window.Views.Trips ||= {}
window.Views.Trips.Builder ||= {}
class Views.Trips.Builder.ShowView extends Views.ApplicationView
  render: ->
    super()
    Widgets.Select2.enable()
    Widgets.DateTimePicker.enable()
    $('.trip_start_date').on 'changeDate', (e) ->
      $('.trip_end_date').datetimepicker('setDate', e.date);


  cleanup: ->
    super()
    Widgets.Select2.cleanup()
    Widgets.DateTimePicker.cleanup()
    $('.trip_start_date').off 'changeDate'

