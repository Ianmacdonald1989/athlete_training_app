class Athlete < ApplicationRecord
  has_many :training_sessions, dependent: :destroy
end
