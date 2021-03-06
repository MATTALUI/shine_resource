// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= turbolinks got rid of this requirement because it breaks the materialize initilization
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require materialize
//= require local-time
//= require Chart.min
$(document).ready(function(){
    $('.collapsible').collapsible();
    $('.sidenav-trigger').sideNav();
    $('select').material_select();
    $('.dropdown-button').dropdown({
      belowOrigin: true
    });
    $('.timepicker').pickatime({
      autoclose: true
    });
    $('.timepicker').on('mousedown', function(event){
      event.preventDefault();
    });

    $('.datepicker').pickadate({
      format: 'mm/dd/yyyy',
      selectMonths: true,
      selectYears: 150,
      autoclose: true
    });
    $('.datepicker').on('mousedown', function(event){
      event.preventDefault();
    });
});
