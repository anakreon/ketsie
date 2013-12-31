class PostsController < ApplicationController
 
  before_action :authenticate_user!
 
  def index
    @posts = current_user.posts.all
    
    @followed_users = current_user.followed_users.all    
    @followed_users.each do |user|
      user.posts.each do |post|        
        @posts.push(post)
      end
    end
    
    @posts.sort! { |a,b| b.updated_at <=> a.updated_at }
    @likeable = Hash.new
    @liked_by = Hash.new
    @posts.each do |post|      
      @likeable[post.id] = ((Like.find_by(post_id: post.id, user_id: current_user.id))?false:true);      
      @likes = Like.where(post_id: post.id)
      if @likes
        @liked_by[post.id] = Array.new       
        @likes.each do |like|
          @liked_by[post.id].push(like.user)
        end       
      end       
    end      
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
  
  def like
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    if(@like)
      @like.destroy
    else
      @like = Like.new
      @like.post_id = params[:post_id]
      @like.user_id = current_user.id
      @like.save
    end
    redirect_to posts_url
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
    @post = Post.find(params[:id])
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
