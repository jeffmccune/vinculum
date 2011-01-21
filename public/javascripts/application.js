var popup = 0; //Is popup open or closed?

//jQuery and prototype are behaving like children. Fix this in some way at some stage so you can use document.ready
function doReady(){
    jQuery(document).keypress(function(e){
       if(e.keyCode == 27 && popup == 1){
            closePopup();
        }
    });
}

function centerPopup(){
//Center popup in middle of window relative to window size
    var windowWidth = document.documentElement.clientWidth;
    var windowHeight = document.documentElement.clientHeight;
    var popupHeight = jQuery("#popupWindow").height();
    var popupWidth = jQuery("#popupWindow").width();
    
    jQuery("#popupWindow").css({
        "position" : "absolute",
        "top" : windowHeight / 2 - popupHeight /2,
        "right" : windowWidth /2 - popupWidth /2
    }
    );
	
}

function openPopup(){
//Open popup
	if(popup == 0){
        centerPopup();
		jQuery(".popup").fadeIn("slow");
		popup = 1;
	}
}

function closePopup(){
//Close popup
	if(popup == 1){
		jQuery(".popup").fadeOut("slow");
		popup = 0;
	}
	
}
