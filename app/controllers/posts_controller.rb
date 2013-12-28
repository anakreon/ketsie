class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new]
  def index
    @posts = current_user.posts.all
  end
  
  def new
    @post = current_user.posts.new    
  end
  
  def edit
    @post = current_user.posts.find(params[:id])
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
   
    if @post.update(params[:post].permit(:text))
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def show
    @post = current_user.posts.find(params[:id])
  end
  
  private
  def post_params
    params.require(:post).permit(:text)
  end
  
end
