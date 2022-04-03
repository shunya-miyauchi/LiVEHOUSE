class CreateLivehouses < ActiveRecord::Migration[6.0]
  def change
    create_table :livehouses do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.text :url, null: false
      t.string :nearest_station
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
