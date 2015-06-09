window.Views.Clients ||= {}
class Views.Clients.IndexView extends Views.ApplicationView
  render: ->
    super()

    $('a[data-toggle="tab"]').on 'show', (e) ->
      $tab = $(e.target)
      $tab_pane = $($tab.data('target'))
      if !$.trim( $tab_pane.html() ).length
        $.get('clients', { letter: $tab.text() }, (data) ->
          $tab_pane.html(data)
        ,"html")

    $(document).on 'ajax:success', '.pagination a', (evt, data, status, xhr) ->
      $tab_pane = $(this).closest('.tab-pane')
      $tab_pane.html(data)


    $(document).on 'ajax:success', '[data-behavior~=delete-client]',  (evt, data, status, xhr) ->
        $tab_pane = $(this).closest('.tab-pane')
        url = $(this).closest('.clients').data('source')
        $tab_pane.load(url)

  cleanup: ->
    super()
    $(document).off 'ajax:success', '[data-behavior~=delete-client]'
    $(document).off 'ajax:success', '.pagination a'


