class ImagesController < ApplicationController
  
  before_action :authenticate_user!
  
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
    @image.save
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
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
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  def index
    @post = Post.find(params[:post_id])
    respond_to do |format|
      #format.html { render partial: 'images' }
      format.js      
    end
  end
  
end
