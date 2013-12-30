class FollowersController < ApplicationController
  before_action :authenticate_user!
  def new
    @users = User.all
    @ids = Array.new
    @users.each do |user|      
        @ids.push(user.id) if ((user.id != current_user.id)&&(!current_user.followed_users.find_by(id: user.id)))
    end    
    @follow = current_user.followed_users.new       
  end
  
  def create    
    @follower = Follower.new    
    @follower.followed_user = User.find(params[:user][:id])
    @follower.following_user = current_user   
    if @follower.save
      redirect_to root_url
    else      
      render 'new'
    end
  end
  
end

