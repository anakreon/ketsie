$(document).ready(function(){
	event_listeners();
	page_specific_js();
});

function event_listeners(){
	//global ajaxSuccess
	$(document).ajaxSuccess(function( event, xhr, settings ){		
		var responseObject;
		try {
			responseObject = $.parseJSON(xhr.responseText);
		} catch (e) {}		
		if(typeof responseObject =='object'){  					
			switch(responseObject.op_type){
				case 'like':				
					Posts.handlers.like_handler(responseObject);			
					break;				
				default:
			}
		}else{
			if(/\/posts\/\d+\/images/.test(settings.url+"")){						
				Images.load_images(xhr.responseText);
			}
			if(/\/posts\/\d+\/comments/.test(settings.url+"")){				
				Comments.load_comments(xhr.responseText);
			}
		}
	});
	
	$('div.post').on('click',function(event){		
		if (event.target === this) {
			Posts.handlers.post_images_comments_handler(this);
		}
	});
	
}

function page_specific_js(){
	switch($('body').attr('class')){
		case 'home_index':
			Posts.helpers.load_first_post_data();
			break;
		default:
	}
}
