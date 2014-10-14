window.Utilities ||= {}

window.Utilities.updateCollectionValues = (collection, value) ->
  $.each collection, (index, item) ->
    $(item).val(value)


$.fn.clearForm = ->
  @each ->
    type = @type
    tag = @tagName.toLowerCase()
    return $(":input", this).clearForm()  if tag is "form"
    if type is "text" or type is "password" or tag is "textarea"
      @value = ""
    else if type is "checkbox" or type is "radio"
      @checked = false
    else @selectedIndex = -1  if tag is "select"
    return


