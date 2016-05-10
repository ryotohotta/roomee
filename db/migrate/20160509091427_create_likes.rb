class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
      t.index :user_id
      t.index :article_id
      t.index :created_at
    end
  end
end
