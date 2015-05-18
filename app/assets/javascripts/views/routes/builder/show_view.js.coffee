window.Views.Routes ||= {}
window.Views.Routes.Builder ||= {}
class Views.Routes.Builder.ShowView extends Views.ApplicationView
  render: ->
    super()
    Widgets.Calculator.enable()

    $(document).on 'cocoon:after-insert', ->
      Widgets.TypeAhead.enable()
  cleanup: ->
    super()
    Widgets.Calculator.cleanup()
    Widgets.TypeAhead.cleanup()
    $(document).off 'cocoon:after-insert'


