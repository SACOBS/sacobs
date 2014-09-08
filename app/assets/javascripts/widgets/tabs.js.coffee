window.Widgets ||= {}
class Widgets.Tabs
  @enable: ->
    $('#Tabbed a').on 'click',(e) ->
      e.preventDefault()
      $(this).tab('show')
  @cleanup: -> $('#Tabbed a').off 'click'