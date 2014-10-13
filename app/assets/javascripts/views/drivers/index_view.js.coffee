window.Views.Drivers ||= {}
class Views.Drivers.IndexView extends Views.ApplicationView
  render: ->
    super()
    $(document).on 'ajax:success', '#driver_search', (evt, data, status, xhr) ->
      $('#drivers > tbody').html(data)

  cleanup: ->
    super()
    $('#city_search').off 'ajax:success'
