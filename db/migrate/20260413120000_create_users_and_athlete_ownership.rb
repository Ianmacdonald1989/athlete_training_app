class CreateUsersAndAthleteOwnership < ActiveRecord::Migration[8.0]
  def up
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true

    TrainingSession.delete_all
    Athlete.delete_all

    add_reference :athletes, :user, null: false, foreign_key: true
  end

  def down
    remove_reference :athletes, :user, foreign_key: true
    drop_table :users
  end
end
