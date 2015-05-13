window.Views.Bookings ||= {}
class Views.Bookings.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    $('a[data-toggle="tab"]').on 'show', (e) ->
      $tab = $(e.target)
      $tab_pane = $($tab.data('target'))
      if !$.trim( $tab_pane.html() ).length
        $tab_pane.html('<div class="text-center"><i class="fa fa-refresh fa-spin fa-3x"></i></div>')
        $.ajax(
          method: "GET",
          url: "bookings",
          data: { type: $tab_pane.data('type') }
          dataType: 'script'
        )

    $('#bookings ul li:first a').tab('show');
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    $('#booking_search').off 'ajax:success'
