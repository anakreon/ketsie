var Posts = {}; 
Posts.handlers = (function(){
	return{
		like_handler: function(response_object){
			Posts.output.like_text(response_object.post_id, response_object.response_text);
		},
		post_images_comments_handler: function(post_div){
			Posts.output.post_lightmark(post_div);
			$.ajax({
			  type: "GET",
			  url: '/posts/'+$(post_div).attr('post_id')+'/comments'
			});
			$.ajax({
			  type: "GET",
			  url: '/posts/'+$(post_div).attr('post_id')+'/images'
			});
		},
		new_post_blur: function(event){
			if($('#post_text').val() == "") Posts.output.new_post_default_text();
		},
		new_post_text: function(){
			if($('#post_text').val() == "Spread your word..."){
				$('#post_text').val('');
				$('#post_text').css('color','black');
			}
		},
		post_menu: function(event){
			Posts.output.post_menu();
			event.stopPropagation();
		},
		hide_menu: function(event){
			Posts.output.hide_menu();
		}
	};
})();

Posts.output = (function(){
	return{
		like_text: function(post_id,like_text){
			var like_element = $('#a_likeLink_'+post_id);		
			like_element.text(like_text); 
		},
		post_lightmark: function(post_div){
			$(post_div).css('background-color','lightred');
		},
		new_post_resize: function(){
			$('#post_text').css('height','auto');
			$('#post_text').css('height',$('#post_text')[0].scrollHeight);        	
		},
		new_post_default_text: function(){
			$('#post_text').val('Spread your word...');
			$('#post_text').css('color','darkgrey');
		},
		post_comment_resize: function(text_element){
			text_element.css('height','auto');
			text_element.css('height',text_element[0].scrollHeight);        	
		},
		post_menu: function(post_menu){			
			$('.post_menu_menu').first().css('display','block');			
		},
		hide_menu: function(){			
			$('.post_menu_menu').css('display','none');
		}
	};
})();

Posts.helpers = (function(){
	return{
		load_first_post_data: function(){
			var first_post = $('div.post').first();
			if(first_post) Posts.handlers.post_images_comments_handler(first_post[0]);
		}
	};	
})();
