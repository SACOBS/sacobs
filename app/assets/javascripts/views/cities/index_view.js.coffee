window.Views.Cities ||= {}
class Views.Cities.IndexView extends Views.ApplicationView
  render: ->
    super()
    $(document).on 'ajax:success', '#city_search', (evt, data, status, xhr) ->
      $('#cities').html(data)

  cleanup: ->
    super()
    $('#city_search').off 'ajax:success'
