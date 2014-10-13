window.Views.Clients ||= {}
class Views.Clients.IndexView extends Views.ApplicationView
  render: ->
    super()
    $(document).on 'ajax:success', '#client_search', (evt, data, status, xhr) ->
      $('#clients').html(data)

  cleanup: ->
    super()
    $('#client_search').off 'ajax:success'
