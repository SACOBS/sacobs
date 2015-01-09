window.Views.Cities ||= {}
class Views.Cities.IndexView extends Views.ApplicationView
  render: ->
    super()
    $('#city_search').on 'ajax:success',  (evt, data, status, xhr) ->
      $('#cities').html(data)

  cleanup: ->
    super()
    $('#city_search').off 'ajax:success'
