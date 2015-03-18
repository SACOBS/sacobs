window.Utilities ||= {}

window.Utilities.updateCollectionValues = (collection, value) ->
  $.each collection, (index, item) ->
    $(item).val(value)


window.Utilities.debounce = (func, wait, immediate) ->
  timeout = undefined
  ->
    context = this
    args = arguments

    later = ->
      timeout = null
      if !immediate
        func.apply context, args
      return

    callNow = immediate and !timeout
    clearTimeout timeout
    timeout = setTimeout(later, wait)
    if callNow
      func.apply context, args
    return


