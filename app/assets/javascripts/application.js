// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/rails/confirm
//= require jquery.turbolinks
//= require bootstrap
//= require bootstrap-sortable
//= require bootstrap-datetimepicker
//= require cocoon
//= require select2
//= require turbolinks
//= require vendor/jquery.plugin
//= require vendor/jquery.calculator
//= require sacobs
//= require initialize
//= require bookings


(function($, undefined_) {
    return $(function() {
        var $body, action, activeController, controller;
        $body = $("body");
        controller = $body.data("controller").replace(/\//g, "_");
        action = $body.data("action");
        activeController = Sacobs[controller];
        if (activeController !== undefined) {
            if ($.isFunction(activeController.init)) {
                activeController.init();
            }
            if ($.isFunction(activeController[action])) {
                return activeController[action]();
            }
        }
    });
})(jQuery);