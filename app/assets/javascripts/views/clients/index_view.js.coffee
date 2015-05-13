window.Views.Clients ||= {}
class Views.Clients.IndexView extends Views.ApplicationView
  render: ->
    super()
    $('a[data-toggle="tab"]').on 'show', (e) ->
      $tab = $(e.target)
      $tab_pane = $($tab.data('target'))
      if !$.trim( $tab_pane.html() ).length
        $tab_pane.html('<div class="text-center"><i class="fa fa-refresh fa-spin fa-3x"></i></div>')
        $.ajax(
          method: "GET",
          url: "clients",
          data: { letter: $tab.text() }
          dataType: 'script'
        )


    $('#directory a:first').tab('show');

    $(document).on 'ajax:success', '#delete_client' ,(evt, data, status, xhr) ->
      $client = $(this).closest('.client')
      $client.fadeOut 'slow', ->
        $client.remove()

  cleanup: ->
    super()
    $('.client').off 'ajax:success', '#delete_client'
