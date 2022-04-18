class ChangeDataImageToBlogs < ActiveRecord::Migration[6.0]
  def up
    change_column :blogs, :image, :json, using: "image::json"
  end

  def down
    change_column :blogs, :image, :text
  end
end
