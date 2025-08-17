json.extract! athlete, :id, :profile, :name, :age, :sport_definition, :email, :created_at, :updated_at
json.url athlete_url(athlete, format: :json)
