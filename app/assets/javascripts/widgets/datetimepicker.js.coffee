window.Widgets ||= {}
class Widgets.DateTimePicker
  @enable:  ->
    $('.datepicker').datetimepicker({pickTime: false });
    $('.timepicker').datetimepicker({pickDate: false, pickSeconds: false});
    $('.datetimepicker').datetimepicker();

    $(document).on 'focus', '.datepicker, .timepicker, .datetimepicker',  ->
      $(this).datetimepicker('show')
      return

    $(document).on 'blur', '.datepicker, .timepicker, .datetimepicker',  ->
      if $(this).data('datetimepicker').viewMode == 0
        $(this).datetimepicker('hide')
      return
  @cleanup: ->
    $('.datepicker').off()
    $('.timepicker').off()
    $('.datetimepicker').off()
    $(document).off 'blur', '.datepicker, .timepicker, .datetimepicker'
    $(document).off 'focus', '.datepicker, .timepicker, .datetimepicker'
