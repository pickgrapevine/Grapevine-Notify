<script type="text/javascript">
    
    /** Initiate the SlideDeck */
    $('.skin-slidedeck dl.slidedeck').slidedeck({
        scroll: 'stop'
    }).
    
    /**
     * Take advantage of the loaded() method of the SlideDeck library to move the vertical navigation
     * for from the slide area to the spine area of that slide
     */
    loaded(function(){
        // Add the square navigation to the spine as the dot navigation.
        $('.skin-slidedeck .slide .verticalSlideNav').each(function(){
            $(this).parents('dd.slide').prevAll('dt.spine:first').append(this);
        });
        
        // Offset the dot navigation so it can be aligned to the bottom of the dt.
        $('.skin-slidedeck .spine .verticalSlideNav').each(function(){
            var liHeight = $(this).find('li').height();
            var ulOffset = ( 62 + ( ($(this).find('li').length - 1) * liHeight ) ) + 'px';
			var ulHeight = ( ($(this).find('li').length - 1) * liHeight ) + 'px';
            $(this).css({
                left: ulOffset, 
				height: ulHeight
            });
        });
            
        
        
    }).
    
    /** Enable vertical slides */
    vertical({
        before: function(deck){
            if(deck.current == 0){
                $(deck.navChildren.context).find('a.vertical-prev-next.previous').hide();
            } else {
                $(deck.navChildren.context).find('a.vertical-prev-next.previous')[0].style.display = "";
            }
            if(deck.current == (deck.slides.length - 1)){
                $(deck.navChildren.context).find('a.vertical-prev-next.next').hide();
            } else {
                $(deck.navChildren.context).find('a.vertical-prev-next.next')[0].style.display = "";
            }
        },
        complete: function(deck){
            if(deck.current == 0){
                $(deck.navChildren.context).find('a.vertical-prev-next.previous').hide();
            } else {
                $(deck.navChildren.context).find('a.vertical-prev-next.previous')[0].style.display = "";
            }
            if(deck.current == (deck.slides.length - 1)){
                $(deck.navChildren.context).find('a.vertical-prev-next.next').hide();
            } else {
                $(deck.navChildren.context).find('a.vertical-prev-next.next')[0].style.display = "";
            }
        }
    });
    
    $('.skin-slidedeck a.vertical-prev-next').bind('click', function(event){
        event.preventDefault();
        switch(this.href.split('#')[1]){
            case "previous":
                $('.skin-slidedeck .slidedeck').slidedeck().vertical().prev();
            break;
            case "next":
                $('.skin-slidedeck .slidedeck').slidedeck().vertical().next();
            break;
        }
    });
    
    /** Hide the previous vertical slide button */
    $('.skin-slidedeck dl.slidedeck a.vertical-prev-next.previous').hide();
     
    $(document).ready(function(){
    
        /**
         * Add goTo() click events to the image grid in slide 1 of the vertical slides on 
         * slide 2 of the horizontal slides in the home page SlideDeck
         */
        $('.skin-slidedeck .slidedeck dd.slide_2 .use-cases img').each(function(index){
            $(this).click(function(){
                $('.skin-slidedeck .slidedeck').slidedeck().vertical().goTo(index+2);
            });
        });
    
    });
    
</script>