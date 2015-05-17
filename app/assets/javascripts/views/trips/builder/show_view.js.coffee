window.Views.Trips ||= {}
window.Views.Trips.Builder ||= {}
class Views.Trips.Builder.ShowView extends Views.ApplicationView
  render: ->
    super()
    $('.trip_start_date').on 'changeDate', (e) ->
      $('.trip_end_date').datetimepicker('setDate', e.date);


  cleanup: ->
    super()
    $('.trip_start_date').off 'changeDate'

