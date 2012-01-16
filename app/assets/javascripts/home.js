$(function(){
  //live is deprecated and this needs to be moved to "on" 
  $("#location_search").live('keyup.autocomplete', function(){
    $(this).autocomplete({
      source: "/location/index",
      minLength: 2
    });
  });
});
