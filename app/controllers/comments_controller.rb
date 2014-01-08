class CommentsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create      
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
    @comment.user_id = current_user.id
    @comment.text = params[:comment][:text]    
    @comment.save
    render @comment    
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])    
    @comment.destroy if @comment.user_id == current_user.id
    respond_to do |format|      
      format.json { head :no_content }
    end
  end
  
  def index
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.js
    end
  end
  
end
