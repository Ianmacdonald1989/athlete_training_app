class RenameTopSpeedAndDistanceInTrainingSessions < ActiveRecord::Migration[8.0]
  def change
    rename_column :training_sessions, :top_speed, :average_speed
    rename_column :training_sessions, :distance, :total_distance
  end
end
