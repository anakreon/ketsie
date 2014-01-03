class CommentsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create      
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
    @comment.user_id = current_user.id
    @comment.text = params[:comment][:text]    
    if @comment.save
      redirect_to root_url
    else
      redirect_to root_url
    end    
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  def index
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html { render @post.comments }      
    end
  end
  
end
