class RenameImageToImagesInBlogs < ActiveRecord::Migration[6.0]
  def change
    rename_column :blogs, :image, :images
  end
end
