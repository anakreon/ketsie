class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :comments
  has_many :posts
  has_many :followers
  has_many :user_follows, through: :followers, :class_name => "User"
  has_many :user_following, through: :followers, :class_name => "User"
  has_many :likes
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
