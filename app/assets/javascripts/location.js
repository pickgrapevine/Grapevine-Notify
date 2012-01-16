// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery ->

    $( "#birds" ).autocomplete({
    source: "search.php",
    minLength: 2,
    select: function( event, ui ) {
    log( ui.item ?
    "Selected: " + ui.item.value + " aka " + ui.item.id :
    "Nothing selected, input was " + this.value );

  $('#location_search').autocomplete
    source: $('#location_search').data('autocomplete-source')
