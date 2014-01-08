var Comments = (function(){
	return{
		load_comments: function(comments_data){
			$('#comments_fixed').html(comments_data); 
		},
		add_comment: function(comment_data){
			$('#comments_fixed').append(comment_data);
		},
		comment_menu: function(event){
			Comments.output.hide_menu();
			Posts.output.post_menu($(this).children('.post_menu_menu'));								
			event.stopPropagation();							
		},
		comment_menu: function(event){
			Posts.output.hide_menu();
		},
		comment_menu_li: function(event){
			Posts.output.hide_menu();
			Posts.helpers.post_menu_redirect($(this));
			event.stopPropagation();
		},
		comment_listeners: function(){
			$('.comment_menu').off();
			$('.comment_menu li').off();
			$('.comment_menu').on('click',Posts.handlers.post_menu);
			$('.comment_menu li').on('click',Comments.post_menu_li);
		},
		post_menu_li: function(event){
			Posts.output.hide_menu();
			Comments.comment_menu_redirect($(this));
			event.stopPropagation();
		},
		comment_menu_redirect: function(element){
			switch(element.attr('type')){
				case 'edit':
				
				break;
				case 'delete':					
					$.ajax({
					  type: "DELETE",
					  url: '/posts/'+element.attr('post_id')+'/comments/'+element.attr('comment_id'),
					  success: function() {					  	
					  	$('.comment[comment_id="'+element.attr('comment_id')+'"]').remove();
					  }
					});
					break;
				default:
			}
		},
		new_comment_submit: function(event){
			if (event.keyCode == 13){
				$(this).closest('form').submit();
			}
		}
	};
})();
