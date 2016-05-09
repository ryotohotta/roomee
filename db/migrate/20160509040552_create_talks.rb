class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.integer :user_id
      t.integer :article_id
      t.text :text
      t.timestamps null: false
    end
  end
end
