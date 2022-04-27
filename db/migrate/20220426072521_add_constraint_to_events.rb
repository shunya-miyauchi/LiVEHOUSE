class AddConstraintToEvents < ActiveRecord::Migration[6.0]
  def up
    execute 'ALTER TABLE events ADD CONSTRAINT for_upsert UNIQUE (held_on, start, livehouse_id)'
  end

  def down
    execute 'ALTER TABLE events DROP CONSTRAINT for_upsert'
  end
end
