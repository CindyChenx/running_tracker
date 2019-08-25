class CreateRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :runs do |t|
      t.integer :user_id
      t.integer :distance
      t.integer :time
      t.string :mood
      t.timestamps
    end
  end
end
