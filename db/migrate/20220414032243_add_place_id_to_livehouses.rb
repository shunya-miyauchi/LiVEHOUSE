class AddPlaceIdToLivehouses < ActiveRecord::Migration[6.0]
  def change
    add_column :livehouses, :place_id, :integer
  end
end
