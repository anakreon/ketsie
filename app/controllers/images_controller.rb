class ImagesController < ApplicationController
  
  def new
    @post = current_user.posts.find(params[:post_id])
    @image = @post.images.new
  end
  
  def create    
    @post = current_user.posts.find(params[:post_id])
    @file = params[:image][:image_data] 
    @stat = @file.tempfile.stat
    @image = @post.images.new(
      :post_id => params[:post_id],             
      :description => params[:image][:description],     
      :file_name => @file.original_filename, 
      :file_type => @file.content_type, 
      :image_data => @file.read
    )        
    if @image.save
      redirect_to posts
    else
     render 'new'
    end
  end
  
  private
  
  def image_params
    params.require(:image).permit(:image_data, :description)
  end
  
end
