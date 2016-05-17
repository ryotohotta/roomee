class AddTweetcheckToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :twittercheck, :integer
  end
end
