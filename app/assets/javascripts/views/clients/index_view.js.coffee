window.Views.Clients ||= {}
class Views.Clients.IndexView extends Views.ApplicationView
  render: ->
    super()
    $('a[data-toggle="tab"]').on 'show', (e) ->
      $tab = $(e.target)
      $tab_pane = $($tab.data('target'))
      if !$.trim( $tab_pane.html() ).length
        $tab_pane.html('<div class="text-center"><i class="fa fa-refresh fa-spin fa-3x"></i></div>')
        $.get('clients.html', { letter: $tab.text() }, 'html').done((data, status, xhr) ->
          $tab_pane.html(data);
        )

    $(document).on 'ajax:success', '.pagination a', (evt, data, status, xhr) ->
      $(this).closest('.tab-pane').html(data)




    $('#directory a:first').tab('show')

  cleanup: ->
    super()
    $('.client').off 'ajax:success', '#delete_client'
