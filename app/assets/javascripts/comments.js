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
			$('.comment_edit textarea').on('keydown', Comments.comment_update_submit);
		},
		post_menu_li: function(event){
			Posts.output.hide_menu();
			Comments.comment_menu_redirect($(this));
			event.stopPropagation();
		},
		comment_menu_redirect: function(element){
			switch(element.attr('type')){
				case 'edit':
					Comments.edit_comment_text(element);
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
		},
		comment_update_submit: function(event){
			if (event.keyCode == 13){
				$(this).closest('form').submit();
				var text = $(this).closest('div.comment').children('div.comment_edit').find('textarea').val();
				$(this).closest('div.comment').children('div.comment_text').html(text);
				Comments.cancel_text_edit();
				return false;
			}
		},
		edit_comment_text: function(element){
			element.closest('div.comment').children('div.comment_text').css('display','none');
			var text = element.closest('div.comment').children('div.comment_text').val();
			element.closest('div.comment').children('div.comment_edit').children('textarea').html(text);
			element.closest('div.comment').children('div.comment_edit').css('display','block');
		},
		cancel_text_edit: function(event){
			$('div.comment_text').css('display','block');
			$('div.comment_edit').css('display','none');
			$('div.comment_edit').children('textarea').html('');
		}
	};
})();
