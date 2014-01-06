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
	
	$(document).on('click', function(event){		
		Posts.handlers.hide_menu();
	});
	
	$('div.post').on('click',function(event){		
		//if (event.target === this) {
			Posts.handlers.post_images_comments_handler(this);
		//}
	});
	
	$('#post_text').on('change',Posts.output.new_post_resize);
	$('#post_text').on('keydown',Posts.output.new_post_resize);
	$('#post_text').on('click',Posts.handlers.new_post_text);
	$('#post_text').on('blur',Posts.handlers.new_post_blur);
	$('.post_comment_text textarea').on('change',function(){
		Posts.output.post_comment_resize($(this));
	});
	$('.post_comment_text textarea').on('keydown', function(){
		Posts.output.post_comment_resize($(this));
	});
	$('#main_logo').on('click',location_reload);	
	$('.post_menu').on('click',Posts.handlers.post_menu);
	
}

function page_specific_js(){
	switch($('body').attr('class')){
		case 'home_index':
			Posts.helpers.load_first_post_data();
			Posts.output.new_post_resize();		
			Posts.output.new_post_default_text();	
			break;
		default:
	}
}

function location_reload(){
	location.reload();
}