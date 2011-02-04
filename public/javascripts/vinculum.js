var popupStatus = 0; //Is popup open or closed?
var actionType = "";
var submenu = "";

jQuery(document).ready(function() {
    jQuery(".disable").attr("disabled", ""); //Experienced some weird caching issue with button disable in Firefox. Remove when you figure it out

    jQuery(document).keypress(function(e){
        if(e.keyCode == 27 && popupStatus == 1){
	    jQuery('#spinner').hide;
            closePopup();
        }
	if(e.keyCode == 13){
		jQuery('.submitbutton').trigger("click");
	}
    });
    var count = 0
    jQuery("#topfield").children(".menu-label").each( function(i) {
    	if(jQuery(this).attr("id").match(/men/)){
	    count += jQuery(this).width() + 18;
	    i++;
	}
    });
    jQuery("#topfield").css({"width" : count});

    jQuery("#topfield").css({
    	"left" : document.documentElement.clientWidth /2 - jQuery("#topfield").width() /2
    })

    //Messy solution to webkit browsers not picking up keypress event on escape. 
    if(jQuery.browser.webkit) {
    	jQuery(document).keyup(function(e){
            if(e.keyCode == 27 && popupStatus == 1){
		jQuery('#spinner').hide;
	       	closePopup();
            }
    	});
    }
    
    jQuery(".menu-button").mouseenter(function(){
    	jQuery(this).css("background", "#FFFFFF");
    }).mouseleave(function() {
    	jQuery(this).css("background", "#F2F2F2");
    })
   

})

function configureMenu(action){
    	jQuery(action).mouseenter(function() {
		submenu = jQuery(this).attr("id").substring(4)
    		jQuery("#sub-" + submenu).css({
			"left" : (jQuery("#men-" + submenu).position().left),
			"top" : (jQuery("#men-" + submenu).css("bottom"))
		});
    		jQuery("#sub-" + submenu).mouseleave(function() {
    			jQuery("#sub-" + submenu).hide();
		})
		jQuery("#sub-" + submenu).show(); }).mouseleave(function(e){
    			if(e.pageX < jQuery("#sub-" + submenu).offset().left || 
			   e.pageX > jQuery("#sub-" + submenu).offset().left + jQuery("#sub-" + submenu).width() ||
			   e.pageY < jQuery("#sub-" + submenu).offset().top ||
			   e.pageY > jQuery("#sub-" + submenu).offset().top + jQuery("#sub-" + submenu).height()){
				jQuery("#sub-" + submenu).hide();
			}
    });
}

//Pagination Effect
function setColor(position){
	jQuery("#" + position).css("background", "#FFFFFF");
}
//Configure tabs for Inventory
function setTabs(){
	jQuery("#tabs").tabs();
}
function spin(){
	jQuery(".disable").attr("disabled", "disabled");
	if (jQuery("#opaque").css("opacity") != "0.1"){
		jQuery("#opaque").css("opacity", "0.1");
	}
	jQuery("#spinner").toggle();
}
//Center popup in middle of window relative to window size
function centerPopup(popup){
    var windowWidth = document.documentElement.clientWidth;
    var windowHeight = document.documentElement.clientHeight;
    var popupHeight = jQuery("#" + popup).height();
    var popupWidth = jQuery("#" + popup).width();
    
    jQuery("#" + popup).css({ //Look at adjusting popup positioning
        "position" : "absolute",
        "bottom" : windowHeight / 2 - popupHeight /2,
        "right" : windowWidth /2 - popupWidth /2,
 //	"top" : "0%",
//	"left" : "10%"
    });
}
//Open, close and style popup windows
function openPopup(popup){
	if(popupStatus == 0){
		jQuery("#opaque").css("opacity", "0.1");
        	centerPopup(popup);
		jQuery("#" + popup).fadeIn("slow");
		popupStatus = 1;
    		jQuery(".popupClose").click(function(){
    			closePopup();
	    	});
		jQuery(".popupClose").mouseover(function(){
			jQuery(".popupClose").css({"background-color" : "#004276", "color":"#F2F2F2", "cursor" : "pointer" });

		}).mouseout(function(){
			jQuery(".popupClose").css({"background-color" : "#F2F2F2", "color":"#004276"});
		});
	}

}
function closePopup(){
	jQuery(".disable").attr("disabled", "");
	if(popupStatus == 1){
        jQuery(".submenu").hide()
		jQuery("#opaque").css("opacity","1");
		jQuery("#popupWindow").fadeOut("slow");
		jQuery("#inputWindow").fadeOut("slow");
		popupStatus = 0;
	}
}
