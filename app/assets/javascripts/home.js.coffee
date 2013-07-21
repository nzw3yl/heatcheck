# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#id').chosen().change ->
    $("#view_button").removeAttr "disabled" if $("#id option:selected").val() isnt ""
    $("#view_button").attr "disabled", true if $("#id option:selected").val() is ""