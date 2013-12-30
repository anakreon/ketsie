class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :comments
  has_many :posts
  has_many :likes
  
  has_many :following_association, :class_name => "Follower", :foreign_key => "followed_user_id"
  has_many :followed_association, :class_name => "Follower", :foreign_key => "following_user_id"
  
  has_many :following_users, :through => :following_association, :source => :following_user  
  has_many :followed_users, :through => :followed_association, :source => :followed_user  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
