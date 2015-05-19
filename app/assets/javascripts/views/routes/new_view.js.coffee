window.Views.Routes ||= {}
class Views.Routes.NewView extends Views.ApplicationView
  render: ->
    super()
    $(document).on 'cocoon:after-insert',(event, destination) ->
      Widgets.TypeAhead.enable()
      destination.find("td input[name*='sequence']").val(destination.index() + 1)

    $(document).on 'cocoon:after-remove',(event, destination) ->
      $('#destinations').find('tr').each (index) ->
        $(this).find("td input[name*='sequence']").val(index)
  cleanup: ->
    super()
    Widgets.TypeAhead.cleanup()
    $(document).off 'cocoon:after-insert'


