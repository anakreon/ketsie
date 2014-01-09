$(document).ready(function(){
	event_listeners();
	page_specific_js();
});

function event_listeners(){
	
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
	$('#post_text').on('keyup', Posts.handlers.new_post_submit);
	$('.post_comment_text textarea').on('change',function(){
		Posts.output.post_comment_resize($(this));
	});
	$('.post_comment_text textarea').on('keydown', function(){
		Posts.output.post_comment_resize($(this));
	});
	
	$('.post_comment_text textarea').on('keyup', Comments.new_comment_submit);
	
	$('#main_logo').on('click',function(){
		window.location = '/';
	});	
	
	$('.post_menu').on('click',Posts.handlers.post_menu);
	$('.post_menu li').on('click',Posts.handlers.post_menu_li);	
	$('.new_comment').on('submit',Posts.handlers.add_comment);
	$('#currentuser_screenname').on('click',function(){
		window.location = '/users/edit';
	});
	$('#currentuser_avatar').on('click',function(){
		window.location = '/user_infos/'+$(this).children('img').attr('user_id')+'/edit';
	});
	$('.new_image_input').on('change',Images.add_image_submit);
	
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