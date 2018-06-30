class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :store
      t.string :station
      t.string :area
      t.string :post_image_name
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
