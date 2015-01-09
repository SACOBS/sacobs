window.Views.Drivers ||= {}
class Views.Drivers.IndexView extends Views.ApplicationView
  render: ->
    super()
    $('#driver_search').on 'ajax:success', (evt, data, status, xhr) ->
      $('#drivers > tbody').html(data)

  cleanup: ->
    super()
    $('#driver_search').off 'ajax:success'
