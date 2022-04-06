class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.date :held_on, null: false
      t.string :open, default: '未定'
      t.string :start, default: '未定'
      t.integer :price
      t.string :artist, default: '未定'
      t.references :livehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
