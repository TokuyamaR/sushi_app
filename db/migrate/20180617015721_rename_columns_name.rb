class RenameColumnsName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :user_image_name, :user_image_name_id
  	rename_column :posts, :post_image_name, :post_image_name_id
  end
end
