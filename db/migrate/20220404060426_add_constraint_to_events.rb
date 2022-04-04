class AddConstraintToEvents < ActiveRecord::Migration[6.0]
  def up
    execute "ALTER TABLE events ADD CONSTRAINT for_upsert UNIQUE (title, held_on, start)"
  end

  def down
    execute "ALTER TABLE events DROP CONSTRAINT for_upsert"
  end
end
