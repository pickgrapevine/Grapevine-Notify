/*Simple Accordion;
*/
(function($)
{
    $.fn.mSimpleToggleAccordion = function(options){
		var defaults = 
        {
           showFirst:true, /*show first toggle content if value : true*/
		   type:"", /*"accordion" ,"toggles"*/
		   speed:500, /*speed of animation, default is 500 milisecond*/
		   easing:"",
		   mEvent:"click"
        };
		var options = $.extend(defaults, options);
		
		return this.each(function(){
			
			var opts = options,
			obj = $(this),			
			toggler = $("> dt",obj),
			toggleContent = $("> dd",obj);
			toggleContent.hide();
			
			toggler.append("<span class='sign'></span");
			
			
			
			/*Set default open/close settings*/
			if(opts.showFirst==true){$('dt:first',obj).addClass("active").next().show();};
			
			toggler.bind(opts.mEvent, function() {
				
				/*for accordion*/
				if(opts.type == "accordion")
				{
					if( $(this).next().is(":hidden") ) { /*If immediate next container is closed...*/
						toggler.removeClass("active").next().slideUp(opts.speed,opts.easing); /*Remove all "active" state and slide up the immediate next container*/
						$(this).addClass("active").next().slideDown(opts.speed,opts.easing); /*Add "active" state to clicked trigger and slide down the immediate next container*/
					}
				}
				/*for toggles*/
				else if(opts.type == "toggles"){
					$(this).toggleClass("active").next().slideToggle(opts.speed,opts.easing);
					
				}
			
			});			
        	
		});
	}
})(jQuery);


/*Simple Tabs;
*/
(function($)
{
    $.fn.mTabs = function(options){
		var defaults = 
        {
		   effect:"slide", /* effect of tab "slide" or fade*/
		   speed:500, /* speed of animation, default is 500 milisecond*/
		   easing:"",
		   mEvent:"click"
        };
		var options = $.extend(defaults, options);
		
		return this.each(function(){
			
			
			
			var opts = options,
			obj = $(this),
			tab = $("> dt",obj),
			tabContent = $("> dd",obj);
			tabContent.hide();
			
			
			$('dt:first',obj).addClass("active").next().show().addClass("active");
			obj.css({height:$('dt:first',obj).next().outerHeight() + tab.outerHeight()});
			tabContent.css({top:tab.outerHeight()-1,left:0});
			
			
			tab.bind(opts.mEvent, function() {

				
				if( $(this).next().is(":hidden") ) {
				$(this).parent().animate({height:$(this).next().outerHeight() + tab.outerHeight()});
				tab.removeClass("active");}
				
				if(opts.effect == "slide")
				{
					tabContent.removeClass("active").slideUp(opts.speed / 2 ,opts.easing); 
					$(this).addClass("active").next().slideDown(opts.speed,opts.easing).addClass("active"); 
					
				}
				else if(opts.effect == "fade"){
					tabContent.removeClass("active").fadeOut(opts.speed / 2,opts.easing); 
					$(this).addClass("active").next().fadeIn(opts.speed,opts.easing).addClass("active");
				}
			});		
        	
		});
	}
})(jQuery);


/*Simple list Animation;
*/
(function($)
{
    $.fn.mSimpleListAnimate = function(options){
		var defaults = 
        {
		   speed:200, /*speed of animation, default is 200 milisecond*/
		   easing:""
        };
		var options = $.extend(defaults, options);
		
		return this.each(function(){
			
			var opts = options,
			obj = $(this),			
			anim = $("> li",obj),
			currentPadding = $(anim).outerWidth() -  $(anim).width();
			
			
			anim.hover(function() {
				//for animating
				
				$(this).stop().animate({paddingLeft:currentPadding + 10},opts.speed,opts.easing);
			
			},function(){
				$(this).stop().animate({paddingLeft:currentPadding},opts.speed*2,opts.easing);
			});			
        	
		});
	}
})(jQuery);



/*Simple Hover Fade Effect;
*/
(function($)
{
    $.fn.mSimpleHoverFade = function(options){
		var defaults = 
        {
		   speed:300 /*speed of animation, default is 300 milisecond*/
        };
		var options = $.extend(defaults, options);
		
		return this.each(function(){
			
			var opts = options,
			obj = $(this);
			
			
			obj.hover(function() {
				/*for animating*/				
				$(this).stop().animate({opacity:.7},opts.speed);
			
			},function(){
				$(this).stop().animate({opacity:1},opts.speed);
			});			
        	
		});
	}
})(jQuery);


/*Icon Box Wrapper;
*/
(function($)
{
    $.fn.mIconBoxWrap = function(options){
		var defaults = 
        {
		   paddingLeft:36 /*equal to the size of icon. default is 36 */
        };
		var options = $.extend(defaults, options);
		
		return this.each(function(){
			
			var opts = options,
			obj = $(this),
			objImageSrc = $(" > .icon-icon",obj).attr("src");		
			$(" > .icon-icon",obj).remove();	
			obj.css({background:"url(" + objImageSrc +") no-repeat left 0",paddingLeft:opts.paddingLeft*1.5});	
		});
	}
})(jQuery);


/*Simple Twitter Intergrator;
*/
(function($)
{
    $.fn.mTwitterIntergrator = function(options){
		var defaults = 
        {
			userName: null,/*username here. default is null*/
			noOfTweets: 3, /*The number of tweets*/
			loaderText: "Loading tweets...",
			showProfileLink: false 
        };
		var options = $.extend(defaults, options);
		
		return this.each(function(){
			
			var opts = options,
			obj = $(this);			
			obj.hide();			
	
			/* Add twitter list to container element*/
			obj.append("<ul id='twitter_update_list' class='tweet'><li></li></ul>");
	
			/*Hide twitter list content*/
			obj.css({position:"relative",display:"display:block;"});
			$("ul#twitter_update_list").hide();

			/*Add Twitter profile*/
			if (opts.showProfileLink) {
				obj.append("<strong>More:</strong> <a id='profileLink' href='http://twitter.com/"+ opts.userName+"'>http://twitter.com/"+ opts.userName +"</a>");
			};
	
			/*Show list wrapper*/			
			$(this).append("<p class='loading-text'>"+opts.loaderText+"</p>").slideDown();
		
			$.getScript("http://twitter.com/javascripts/blogger.js");			
			$.getScript("http://twitter.com/statuses/user_timeline/"+opts.userName+".json?callback=twitterCallback2&count="+opts.noOfTweets, function() {			
					
				var tweetContent = $("ul#twitter_update_list li");
				
				/*Replace content with custom style*/
				tweetContent.each(function() {
					var eachP = $(" > span",this);
					var eachEm = $(" > a:last-child",this);
					
					eachP.replaceWith("<p>" + eachP.html() + "</p>");
					eachP.remove();
					
					eachEm.replaceWith("<em>" + eachEm.html() + "</em>");
					eachEm.remove();
				});				
				
				$(".loading-text").fadeOut();
				$("ul#twitter_update_list").slideDown(1000);
				
			});			
			
		});
	}
})(jQuery);




$(document).ready(function(){
	$("dl.m-simple-accordion").mSimpleToggleAccordion({
		showFirst:true,
		type:"accordion",
		speed:300,
		mEvent:"mouseover"
	});
	
	
	$("dl.m-simple-toggle").mSimpleToggleAccordion({
		type:"toggles",
		showFirst:false,
		speed:1000,
		easing:"easeOutBounce",
		mEvent:"click"
	});
	
	$(".m-simple-tabs").mTabs({
		speed:1000,
		easing:"easeOutBounce",
		 effect:"fade",
		 mEvent:"click"
	});
});


$(document).ready(function(){

	$(".unordered-list").mSimpleListAnimate();
	
	$(".maxx-notification .close").click(function () {
		$(this).parent().fadeTo(400, 0, function(){ // Links with the class "close" will close parent
			$(this).slideUp(400);
		});
	
		return false;
	});
	
	$(".maxx-button").mSimpleHoverFade();
	
	$(".icon-boxes-wrapper").mIconBoxWrap();
	
	$("#twitter").mTwitterIntergrator({
		userName: "pickgrapevine",
		noOfTweets: 3,
		loaderText: "Loading tweets..."
	});

});


$(document).ready(function(){
	/*Table*/
	$("table.m-table thead tr th:first-child").addClass("first-child");
	$("table.m-table thead tr th:last-child").addClass("last-child");
	$("table.m-table tbody tr:first-child th:first-child").addClass("first-child");
	$("table.m-table tbody tr:last-child th:first-child").addClass("last-child");
	$("table.m-table tbody tr:odd").addClass("alternate");
	$("table.m-table tbody tr > td:first-child").addClass("first-child");
});





