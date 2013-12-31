class UserInfosController < ApplicationController
 
  before_action :authenticate_user!
  
  def edit
    @user = current_user
    @user_info = current_user.user_info
    if @user_info.nil? then      
      @user_info = UserInfo.new
      current_user.user_info = @user_info
    end   
  end
  
  def avatar 
    @user_info = UserInfo.find(params[:id]) 
    send_data @user_info.avatar_image, :filename => @user_info.file_name, :type => @user_info.file_type
  end  

  def update
    @user_info = current_user.user_info
    @user_info.personal_description = params[:user_info][:personal_description]
    if params[:user_info][:avatar_image]
      @file = params[:user_info][:avatar_image] 
      @stat = @file.tempfile.stat
      @user_info.file_type = @file.content_type 
      @user_info.avatar_image = @file.read
      @user_info.file_name = @file.original_filename
    end
    if @user_info.save
      redirect_to root_url
    else
      render 'edit'
    end
  end
  
  def destroy_avatar
    @user_info = current_user.user_info
    @user_info.file_type = ""
    @user_info.avatar_image = ""
    @user_info.file_name = ""
    if @user_info.save
      redirect_to root_url
    else
     render 'edit'
    end
  end
  
end
