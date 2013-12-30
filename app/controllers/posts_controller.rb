class PostsController < ApplicationController
  before_action :authenticate_user!
 
  def index
    @posts = current_user.posts.all
    @followed_users = current_user.followed_users.all
    #@followed_posts = Array.new 
    @followed_users.each do |user|
      user.posts.each do |post|
        #@followed_posts.push(post)
        @posts.push(post)
      end
    end
    @posts.sort! { |a,b| b.updated_at <=> a.updated_at }
  end
  
  def new
    @post = current_user.posts.new
    @image = @post.images.new
  end
  
  def edit
    @post = current_user.posts.find(params[:id])
    @images = @post.images.all
    if !@images then @image = @post.images.new end
  end
  
  def create    
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
     render 'new'
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
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def show
    @post = current_user.posts.find(params[:id])
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
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
