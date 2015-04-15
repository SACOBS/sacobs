window.Views.Buses ||= {}
class Views.Buses.IndexView extends Views.ApplicationView
  render: ->
    super()
    $('.bus').on 'ajax:success', '#delete_bus' ,(evt, data, status, xhr) ->
     $row = $(this).closest('tr')
     $row.children('td').animate({ padding: 0 }).wrapInner('<div />').children().slideUp ->
       $(this).remove()
       return

  cleanup: ->
    super()
    $('.bus').off 'ajax:success'

