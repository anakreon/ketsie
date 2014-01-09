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
    end
  end
  
  def destroy
    @follower = Follower.find_by(followed_user_id: params[:id], following_user_id: current_user.id)
    @follower.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
end

