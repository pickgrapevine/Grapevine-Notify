$(function(){
  function appendItemIfNotNullOrEmpty(data, data_item){
    if(data_item){
      data.append('<br/>' +data_item);
    }
    return data;
  }
  //live is deprecated and this needs to be moved to "on" 
  $("#location_search").live('keyup.autocomplete', function(){
    $(this).autocomplete({
      source: "/location/index",
      minLength: 2,
    })
    .data( "autocomplete" )._renderItem = function( ul, item ) {
     var li =  $( "<li></li>" )
      .data( "item.autocomplete", item )
      .append( "<a>" + item.label + "<br/>" + item.address_line_1);
      li = appendItemIfNotNullOrEmpty(li, item.address_line_2);
      li.append("</a>").appendTo( ul );
      return li;
    };

  });
});
