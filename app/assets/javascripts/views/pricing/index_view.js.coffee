window.Views.Pricing ||= {}
class Views.Pricing.IndexView extends Views.ApplicationView
  render: ->
    super()
    $("input[type='radio']").on "change", ->
      route_id  = parseInt(this.value)
      $('#connections-list li').hide().filter( ->
         parseInt($(this).data('route')) == route_id
      ).show()

    $('#connection-search').on 'keyup click input', ->
     if this.value.length > 0
      if $("input[type='radio']").is(":checked")
        $('#connections-list li').hide().filter( ->
          parseInt($(this).data('route')) == parseInt($("input[type='radio']:checked").val())
        ).filter( ->
            $(this).text().toLowerCase().indexOf($('#connection-search').val().toLowerCase()) != -1
          ).show()
      else
        $('#connections-list li').hide().filter( ->
             $(this).text().toLowerCase().indexOf($('#connection-search').val().toLowerCase()) != -1
         ).show()
     else
       $('#connections-list li').hide

    $('#show_pricing').on 'ajax:success',  (evt, data, status, xhr) ->
      $('.quote').html(data)


  cleanup: ->
   super()
   $("input[type='radio']").off
   $('#connection-search').off
   $('#show_pricing').off 'ajax:success'

