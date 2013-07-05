# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#contract_start_date").datepicker
    defaultDate: "+1w"
    changeMonth: true
    numberOfMonths: 1
    dateFormat: 'yy-mm-dd'
    onClose: (selectedDate) ->
      $("#contract_expiry_date").datepicker "option", "minDate", selectedDate

  $("#contract_expiry_date").datepicker
    defaultDate: "+1w"
    changeMonth: true
    numberOfMonths: 1
    dateFormat: 'yy-mm-dd'
    onClose: (selectedDate) ->
      $("#contract_start_date").datepicker "option", "maxDate", selectedDate
  
  $('#contract_customer_id').chosen()

  $('#contract_partner_id').chosen()