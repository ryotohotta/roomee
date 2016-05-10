class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :article, counter_cache: :likes_count

   validates :user, presence: true
   validates :user_id, uniqueness: { scope: :article_id }
   validates :article, presence: true
end
