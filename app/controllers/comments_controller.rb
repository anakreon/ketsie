class CommentsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create      
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
    @comment.user_id = current_user.id
    @comment.text = params[:comment][:text]    
    if @comment.save
      redirect_to @post
    else
      redirect_to root_url
    end    
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_url(:id => params[:post_id]) }
      format.json { head :no_content }
    end
  end
  
end
