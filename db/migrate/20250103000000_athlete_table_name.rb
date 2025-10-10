class AthleteTableName < ActiveRecord::Migration[8.0]
  def up
    # Rename table only if it exists and the target doesn't exist
    if table_exists?(:athlete) && !table_exists?(:athletes)
      rename_table :athlete, :athletes
    end
    
    # Update foreign keys if necessary
    if foreign_key_exists?(:training_sessions, :athlete)
      remove_foreign_key :training_sessions, :athlete
      add_foreign_key :training_sessions, :athletes
    end

    # Drop athlete_profile table if it exists
    drop_table :athlete_profile if table_exists?(:athlete_profile)
  end

  def down
    # Reverse rename only if the singular table exists
    if table_exists?(:athletes) && !table_exists?(:athlete)
      rename_table :athletes, :athlete
    end

    if foreign_key_exists?(:training_sessions, :athletes)
      remove_foreign_key :training_sessions, :athletes
      add_foreign_key :training_sessions, :athlete
    end

    # Recreate athlete_profile table (simplified)
    create_table :athlete_profile do |t|
      t.string :name
      t.integer :age
      t.string :sport_definition
      t.timestamps
    end unless table_exists?(:athlete_profile)
  end
end

