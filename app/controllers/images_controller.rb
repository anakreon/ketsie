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
      redirect_to @post
    else
     render 'new'
    end
  end
  
    
  def show
    @image = Image.find(params[:id])
  end
  
  def image 
    @image = Image.find(params[:id]) 
    send_data @image.image_data, :filename => @image.file_name, :type=>@image.file_type
  end  
  
  def destroy
    @post = current_user.posts.find(params[:post_id])
    @image = @post.images.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html { redirect_to edit_post_url(:id => params[:post_id]) }
      format.json { head :no_content }
    end
  end
  
  private
  
  def image_params
    params.require(:image).permit(:image_data, :description)
  end
  
end
