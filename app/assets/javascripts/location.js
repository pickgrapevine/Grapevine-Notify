// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery ->
  $('#location_search').autocomplete
    source: $('#location_search').data('autocomplete-source')
