// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
    alert("not cached");
    //live is deprecated and this needs to be moved to "on" 
    $("#location_search").live('keyup.autocomplete', function(){
        $(this).autocomplete({
            source: "/location/index",
            minLength: 2
        });
    });
