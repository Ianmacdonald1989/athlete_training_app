class CreateTrainingSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :training_sessions do |t|
      t.datetime :start_time
      t.datetime :finish_time
      t.integer :top_speed
      t.float :distance
      t.date :date
      t.references :athlete, null: false, foreign_key: true

      t.timestamps
    end
  end
end
