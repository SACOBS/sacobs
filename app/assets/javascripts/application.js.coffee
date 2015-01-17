#= require jquery
#= require jquery-ui/effect.all
#= require jquery_ujs
#= require jquery.plugin
#= require jquery.calculator
#= require nprogress
#= require nprogress-ajax
#= require nprogress-turbolinks
#= require jsurl
#= require moment
#= require bootstrap
#= require bootstrap-sortable
#= require bootstrap-datetimepicker
#= require twitter/bootstrap/rails/confirm
#= require cocoon
#= require unobtrusive_flash
#= require unobtrusive_flash_bootstrap
#= require obfuscatejs
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
    Turbolinks.enableTransitionCache();
    $.fn.twitter_bootstrap_confirmbox.defaults.title = 'Sacobs'
    pageLoad()
    $(document).on 'page:load', pageLoad
    $(document).on 'page:before-change', ->
      localStorage.clear()
      window.applicationView.cleanup()
      true
    $(document).on 'page:restore', ->
      localStorage.clear()
      window.applicationView.cleanup()
      pageLoad()
      true



