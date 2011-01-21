var popupStatus = 0; //Is popup open or closed?

jQuery(document).ready(function() {
    jQuery(document).keypress(function(e){
        if(e.keyCode == 27 && popupStatus == 1){
            closePopup();
        }
    });
})

//Pagination Effect
function setColor(position){
	jQuery("#" + position).css("background", "#FFFFFF");
}

//Configure tabs for Inventory
function setTabs(){
	jQuery("#tabs").tabs();
}

//Center popup in middle of window relative to window size
function centerPopup(popup){
    var windowWidth = document.documentElement.clientWidth;
    var windowHeight = document.documentElement.clientHeight;
    var popupHeight = jQuery("#" + popup).height();
    var popupWidth = jQuery("#" + popup).width();
    
    jQuery("#" + popup).css({
        "position" : "absolute",
        "bottom" : windowHeight / 2 - popupHeight /2,
        "right" : windowWidth /2 - popupWidth /2,
    }
    );
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
	}

}

function closePopup(){
	if(popupStatus == 1){
		jQuery("#opaque").css("opacity","1");
		jQuery("#popupWindow").fadeOut("slow");
		jQuery("#inputWindow").fadeOut("slow");
		popupStatus = 0;
	}
}
