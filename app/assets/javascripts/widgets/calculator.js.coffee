window.Widgets ||= {}
class Widgets.Calculator
  @enable:  ->
    $('.calc').calculator()
  @cleanup: ->
    $('.calc').off()