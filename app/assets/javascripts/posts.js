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
