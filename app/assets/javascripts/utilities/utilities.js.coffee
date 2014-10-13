window.Utilities ||= {}

window.Utilities.updateCollectionValues = (collection, value) ->
  $.each collection, (index, item) ->
    $(item).val(value)


window.Utilities.hello = ->
  alert 'hello'
