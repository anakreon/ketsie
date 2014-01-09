class HomeController < ApplicationController
  
  before_action :authenticate_user!
  
  def index   
    @current_post = nil
    
    @current_user = current_user     
    @posts = current_user.posts.all
    
    @followed_users = current_user.followed_users.all    
    @followed_users.each do |user|
      user.posts.each do |post|
        @posts.push(post) if !post.text.nil?
      end
    end    
    
    @posts.sort! { |a,b| b.updated_at <=> a.updated_at }
    @likeable = Hash.new
    @liked_by = Hash.new
    @posts.each do |post|     
      @current_post = post if @current_post.nil?     
      @likeable[post.id] = ((Like.find_by(post_id: post.id, user_id: current_user.id))?false:true);      
      @likes = Like.where(post_id: post.id)
      if @likes
        @liked_by[post.id] = Array.new       
        @likes.each do |like|
          @liked_by[post.id].push(like.user)
        end       
      end       
    end
    
    if(params[:post_id])
      @current_post = params[:post_id]
    end
    
    @new_post = current_user.posts.new
      
  end
  
end
