class HomeController < ApplicationController
  
  def index
    @followed = current_user.followed_users.all if !current_user.nil?
    @following = current_user.following_users.all if !current_user.nil?
  end
  
end
