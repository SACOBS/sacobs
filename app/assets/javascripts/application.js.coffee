#= require jquery
#= require jquery-ui/effect.all
#= require jquery_ujs
#= require jquery.plugin
#= require jquery.calculator
#= require jquery.blockui
#= require jsurl
#= require twitter/bootstrap/rails/confirm
#= require bootstrap
#= require bootstrap-sortable
#= require bootstrap-datetimepicker
#= require cocoon
#= require select2
#= require unobtrusive_flash
#= require unobtrusive_flash_bootstrap
#= require obfuscatejs
#= require fullcalendar
#= require turbolinks
#= require_tree .


pageLoad = ->
  className = $('body').attr('data-class-name')
  window.applicationView = try
    eval("new #{className}()")
  catch error
    new Views.ApplicationView()
  window.applicationView.render()



head ->
  $ ->
    $.fn.twitter_bootstrap_confirmbox.defaults.title = 'Sacobs'
    pageLoad()
    $(document).ajaxStart($.blockUI).ajaxStop $.unblockUI
    $(document).on 'page:load', pageLoad
    $(document).on 'page:before-change', ->
      window.applicationView.cleanup()
      true
    $(document).on 'page:restore', ->
      window.applicationView.cleanup()
      pageLoad()
      true
    $(document).on "page:fetch",  $.blockUI
    $(document).on "page:receive", $.unblockUI



