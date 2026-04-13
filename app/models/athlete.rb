class Athlete < ApplicationRecord
  belongs_to :user

  has_many :training_sessions, dependent: :destroy
end
