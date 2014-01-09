var Posts = {}; 
Posts.handlers = (function(){
	return{		
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
			Posts.output.set_post_id($(post_div).attr('post_id'));
			
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
			Posts.output.hide_menu();
			Posts.output.post_menu($(this).children('.post_menu_menu'));								
			event.stopPropagation();							
		},
		post_menu_li: function(event){
			Posts.output.hide_menu();
			Posts.helpers.post_menu_redirect($(this));
			event.stopPropagation();
		},
		hide_menu: function(event){
			Posts.output.hide_menu();
		},
		new_post_submit: function(event){
			if (event.keyCode == 13){
				$('#new_post').submit();
			}
		},
		add_comment: function(event){
			var valuesToSubmit = $(this).serialize();
			var form = $(this);
		    $.ajax({
		      url: $(this).attr('action'), //sumbits it to the given url of the form
		      data: valuesToSubmit,
		      type: 'POST',		      
		      success: function(response){
		      	form.find('textarea').val('');
		     	Comments.add_comment(response);
		      }
		    });
		    
		    return false; // prevents normal behaviour		
		},
		post_update_submit: function(event){
			if (event.keyCode == 13){
				$(this).closest('form').submit();
				return false;
			}
		},
		post_search: function(event){
			if (event.keyCode == 13){
				Posts.output.posts_filter($(this).val());
			}
		}
	};
})();

Posts.output = (function(){
	return{
		like_text: function(post_id,like_text,liked_by){
			var like_element = $('#a_likeLink_'+post_id);		
			like_element.text(like_text); 
		},
		like_likedby: function(post_id, liked_by){
			var likedby_element = $('.post[post_id="'+post_id+'"]').children('.post_liked_by');
			likedby_element.text(liked_by);			
		},		
		post_lightmark: function(post_div){
			$('.post').css('box-shadow','none');
			$(post_div).css('outline','none');
			$(post_div).css('box-shadow','1px 1px 5px #008000');					
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
		post_menu: function(post_menu_element){						
			post_menu_element.slideDown(150);			
		},
		hide_menu: function(){						
			$('.post_menu_menu').slideUp(150);
		},
		set_post_id: function(post_id){
			$('#sel_post_id').attr('post_id',post_id);
		},
		edit_post_text: function(element){
			element.closest('div.post').children('div.post_text').css('display','none');
			var text = element.closest('div.post').children('div.post_text').val();
			element.closest('div.post').children('div.post_edit').children('textarea').html(text);
			element.closest('div.post').children('div.post_edit').css('display','block');
		},
		cancel_text_edit: function(event){
			$('div.post_text').css('display','block');
			$('div.post_edit').css('display','none');
			$('div.post_edit').children('textarea').html('');
		},
		posts_filter: function(filter){
			if(filter){
				$('div.post').filter(function(index) {
    				return !($(this).children('.post_text').html().indexOf(filter) >= 0);
  				}).css("display", "none");
  				
  				$('div.post').filter(function(index) {
    				return ($(this).children('.post_text').html().indexOf(filter) >= 0);
  				}).css("display", "block");
			}else{
				$('div.post').css("display", "block");
			}
		}
	};
})();

Posts.helpers = (function(){
	return{
		load_first_post_data: function(){
			var sel_post_id = $('#sel_post_id').attr('post_id');
			var first_post = $(document).find('div.post[post_id="'+sel_post_id+'"]');
			if(first_post) Posts.handlers.post_images_comments_handler(first_post[0]);
		},
		post_menu_redirect: function(element){
			switch(element.attr('type')){
				case 'edit':
					Posts.output.edit_post_text(element);
				break;
				case 'delete':	
					if(confirm('?')){				
						$.ajax({
						  type: "DELETE",
						  url: '/posts/'+element.attr('post_id'),
						  success: function() {					  	
						  	$('.post[post_id="'+element.attr('post_id')+'"]').remove();
						  }
						});
					}
					break;
				default:
			}
		}
	};	
})();
