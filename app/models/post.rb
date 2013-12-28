class Post < ActiveRecord::Base
  has_many :comments
  has_many :likes
  has_many :images
  belongs_to :user
end
