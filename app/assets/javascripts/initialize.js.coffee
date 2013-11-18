$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Sacobs'

$ ->
  $('.datepicker').datetimepicker({pickTime: false});
  $('.datetimepicker').datetimepicker();


  $('select[rel="autocomplete"]').each ->
    $(this).select2({
      width: 'element',
      placeholder: $(this).data('default')
    });

 






