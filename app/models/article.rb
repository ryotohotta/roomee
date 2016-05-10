class Article < ActiveRecord::Base
  belongs_to :user
  has_many :talks
  has_many :likes, dependent: :destroy
  mount_uploader :image, ImageUploader

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end