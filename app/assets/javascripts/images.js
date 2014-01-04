var Images = (function(){
	return{
		load_images: function(images_data){
			$('#images_fixed').html(images_data); 
			Images.load_image_preview($('.image_preview img').first(),$('.image_preview p').first());
			Images.set_image_preview_listener();
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
		}		
	};
})();