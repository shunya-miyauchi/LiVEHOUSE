class AddUrlToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :url, :text
  end
end
