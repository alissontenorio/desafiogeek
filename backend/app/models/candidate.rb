class Candidate < ApplicationRecord
    validates :city, presence: true
    validates :experience, presence: true

    has_many :candidate_technologies, dependent: :destroy
end