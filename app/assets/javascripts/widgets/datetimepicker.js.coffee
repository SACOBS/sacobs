window.Widgets ||= {}
class Widgets.DateTimePicker
  @enable:  ->
    $('.datepicker').datetimepicker({pickTime: false});
    $('.timepicker').datetimepicker({pickDate: false, pickSeconds: false});
    $('.datetimepicker').datetimepicker();
  @cleanup: ->
    $('.datepicker').off()
    $('.timepicker').off()
    $('.datetimepicker').off()