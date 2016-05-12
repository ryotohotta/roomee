class Article < ActiveRecord::Base
  belongs_to :user
  has_many :talks
  has_many :likes, dependent: :destroy
  mount_uploader :image, ImageUploader

  def user_like(user_id)
    Like.find_by(user_id: user_id, article_id: id)
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end