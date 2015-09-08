window.App ||= {}

class App.DateTimePicker
  constructor: () ->
    $('.datepicker').datetimepicker({pickTime: false });
    $('.timepicker').datetimepicker({pickDate: false, pickSeconds: false});
    $('.datetimepicker').datetimepicker();

  render: ->
    $(document).on 'focus', '.datepicker, .timepicker, .datetimepicker',  ->
     $(this).datetimepicker('show')
     return

    $(document).on 'blur', '.datepicker, .timepicker, .datetimepicker',  ->
      if $(this).data('datetimepicker').viewMode == 0
       $(this).datetimepicker('hide')
      return


$(document).on "page:change", ->
  return unless $(".datepicker, .timepicker, .datetimepicker").length > 0
  dateTimePicker = new App.DateTimePicker
  dateTimePicker.render()