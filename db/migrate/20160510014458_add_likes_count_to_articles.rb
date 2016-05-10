class AddLikesCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :likes_count, :integer
  end
end
