class PostsController < ApplicationController
 
  before_action :authenticate_user!
  
  include PostsHelper
   
  def edit
    @post = current_user.posts.find(params[:id])
    @images = @post.images.all
    if !@images then @image = @post.images.new end
  end
  
  def create    
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def like
    @post_id = params[:post_id];     
    @like = Like.find_by(post_id: @post_id, user_id: current_user.id)
    @response_text = ""
    if(@like)
      @like.destroy      
      @response_text = get_like_text();
    else
      @like = Like.new
      @like.post_id = @post_id
      @like.user_id = current_user.id
      if @like.save then @response_text = get_unlike_text() end
    end
    
    @liked_by = Array.new    
    @likes = Like.where(post_id: @post_id)
    if @likes   
      @likes.each do |like|
        @liked_by.push(like.user)
      end       
    end         
     
    respond_to do |format|      
      format.js      
    end   
  end
  
  def update
    @post = current_user.posts.find(params[:id])
       
    if(params[:image])
      @image = @post.images.new(image_params)
      @image.post_id = current_user.id;
      if !@image.save
        render 'edit'
      end
    end
   
    if @post.update(params[:post].permit(:text))      
      redirect_to root_url
    else
      render 'edit'
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    respond_to do |format|      
      format.json { head :no_content }
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:text)
  end
  
  def image_params
    params.require(:post).permit(:image_data, :description)
  end
  
end
