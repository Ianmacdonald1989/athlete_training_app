class CreateAthletes < ActiveRecord::Migration[8.0]
  def change
    create_table :athlete do |t|
      t.string :profile
      t.string :name
      t.integer :age
      t.string :sport_definition
      t.string :email

      t.timestamps
    end
  end
end
