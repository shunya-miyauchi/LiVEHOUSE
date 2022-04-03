class AddIndexEventsHeldOn < ActiveRecord::Migration[6.0]
  def change
    add_index :events, :held_on
  end
end
