window.Views.Clients ||= {}
class Views.Clients.IndexView extends Views.ApplicationView
  render: ->
    super()
    $('#client_search').on 'ajax:success',  (evt, data, status, xhr) ->
      $('#clients').html(data)

  cleanup: ->
    super()
    $('#client_search').off 'ajax:success'
