window.Views.Pricing ||= {}
class Views.Pricing.IndexView extends Views.ApplicationView
  render: ->
    super()

    $connections = $('#connections-list').find('li')

    $("input[type='radio']").on "change", ->
      $connections.detach().filter('[data-route=' + parseInt(this.value) + ']').appendTo('#connections-list')


    $('#connection-search').on 'keyup', ->
         search_term = this.value.toLowerCase()
         $connections.detach().filter(->
                       $(this).text().toLowerCase().indexOf(search_term) == 0
                     ).appendTo('#connections-list')

    $(document).on 'ajax:success', '#show_pricing' ,(evt, data, status, xhr) ->
      $('.quote').html(data)


  cleanup: ->
   super()
   $("input[type='radio']").off
   $('#connection-search').off
   $('#show_pricing').off 'ajax:success'

