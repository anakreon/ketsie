var Images = (function(){
	return{
		load_images: function(images_data){
			$('#images_fixed').html(images_data); 
			Images.load_image_preview($('.image_preview img').first(),$('.image_preview p').first());
			Images.set_image_preview_listener();
			Images.delete_image_listener();
		},
		load_image_preview: function(img, descr){			
			$('#image_detail_img').html(img.clone());
			$('#image_detail_descr').html(descr.html());					
		},
		set_image_preview_listener: function(){				
			$('.image_preview').off();
			$('.image_preview').on('click',function(event){				
				Images.load_image_preview($(this).children('img'),$(this).children('p'));				
			});
		},
		add_image_submit: function(event){
			$(this).closest('form.new_image').submit();
			$.ajax({
			  type: "GET",
			  url: '/posts/'+$(this).attr('post_id')+'/images'
			});		
		},
		delete_image_listener: function(){
			$('#image_delete img').off();
			$('#image_delete img').on('click',Images.delete_image);
		},
		delete_image: function(event){
			var deleted_image = $(this).closest('#image_detail').find('#image_detail_img img');
			$.ajax({
			  type: "DELETE",
			  url: '/posts/'+deleted_image.attr('post_id')+'/images/'+deleted_image.attr('image_id'),
			  success: function(){
			  	$.ajax({
				  type: "GET",
				  url: '/posts/'+deleted_image.attr('post_id')+'/images'
				});	
			  }
			});		
		}
	};
})();
