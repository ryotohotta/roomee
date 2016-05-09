class Article < ActiveRecord::Base
  belongs_to :user
  has_many :talks
  mount_uploader :image, ImageUploader
end