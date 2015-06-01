window.Views.Bookings ||= {}
class Views.Bookings.IndexView extends Views.ApplicationView
  render: ->
    super()
    $('a[data-toggle="tab"]').on 'show', (e) ->
      $tab = $(e.target)
      $tab_pane = $($tab.data('target'))
      if !$.trim( $tab_pane.html() ).length
        $.get('bookings', { type: $tab_pane.data('type') }, (data) ->
          $tab_pane.html(data)
          $.bootstrapSortable(applyLast=true)
        ,"html")

    $(document).on 'ajax:success', '.pagination a', (evt, data, status, xhr) ->
      $tab_pane = $(this).closest('.tab-pane')
      $tab_pane.html(data)
      $.bootstrapSortable(applyLast=true)


  cleanup: ->
    super()
    $(document).off 'ajax:success', '.pagination a'
