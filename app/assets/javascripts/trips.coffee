$(document).on "page:change", ->
  return unless $(".trips").length > 0
  $('.trip_start_date').on 'changeDate', (e) ->
    $('.trip_end_date').datetimepicker('setDate', e.date);
