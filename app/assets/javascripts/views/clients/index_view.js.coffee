window.Views.Clients ||= {}
class Views.Clients.IndexView extends Views.ApplicationView
  render: ->
    super()
    $(document).on 'ajax:success', '#client_search', (evt, data, status, xhr) ->
      $('#clients').html(data)

    $('.client').on 'ajax:success', '#delete_client' ,(evt, data, status, xhr) ->
      row = $(this).closest('tr')
      row.children('td').animate({ padding: 0 }).wrapInner('<div />').children().slideUp ->
        $(this).remove()
  cleanup: ->
    super()
    $('#client_search').off 'ajax:success'
