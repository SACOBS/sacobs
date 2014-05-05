SACOBS =
  common:
    init: ->
      $(document).ajaxStart($.blockUI).ajaxStop $.unblockUI
      $(document).on "page:fetch", $.blockUI
      $(document).on "page:receive", $.unblockUI

      $(document).on 'cocoon:after-insert', ->
        UTIL.init_select2()

      $(document).on 'hidden', '.modal', ->
        $(this).remove()

      $('.datepicker').datetimepicker({pickTime: false});
      $('.timepicker').datetimepicker({pickDate: false, pickSeconds: false});
      $('.datetimepicker').datetimepicker();
      $('[rel~="tooltip"]').tooltip();

      UTIL.init_select2()

  bookings_builder:
    init: ->
      $(document).on 'click', '#new_client',(e) ->
        e.preventDefault()
        $('.new_client_fields').fadeIn 'slow'
        $('#new_client').hide()

      $(document).on 'change', '.amount', ->
        UTIL.refresh_total()


  buses:
    init: ->
    edit: ->
     UTIL.init_tabs()

  routes:
    init: ->
    edit: ->
     UTIL.init_tabs()
     $('.calc').calculator();

  routes_builder:
    init: ->
      $('.calc').calculator();



  trips:
    init: ->
    edit: ->
     UTIL.init_tabs()

  trips_builder:
    init: ->
      $('.trip_start_date').on 'changeDate', (e) ->
       $('.trip_end_date').datetimepicker('setDate', e.date);



# action-specific code
UTIL =
  exec: (controller, action) ->
    ns = SACOBS
    action = (if (action is `undefined`) then "init" else action)
    ns[controller][action]()  if controller isnt "" and ns[controller] and typeof ns[controller][action] is "function"
    return

  init: ->
    body = document.body
    controller = body.getAttribute("data-controller").replace(/\//g, "_")
    action = body.getAttribute("data-action")
    UTIL.exec "common"
    UTIL.exec controller
    UTIL.exec controller, action
    return


  init_tabs: ->
    $('#Tabbed a').on 'click',(e)->
      e.preventDefault()
      $(this).tab('show')
    return

  init_select2: ->
    $('select[rel="autocomplete"]').select2({
      width: 'element',
      placeholder: $(this).data('default')
    });
    return

  refresh_total: ->
    total = 0
    $('#line_items tr.line_item').each ->
      value = Number($(this).find('td.amount input').val())
      value = value * -1 if $(this).data('type') == 'credit'
      total += value if (!isNaN(value))
    $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")




$(document).ready UTIL.init