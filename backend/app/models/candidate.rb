class Candidate < ApplicationRecord
    validates :city, presence: true
    validates :experience, presence: true

    has_many :candidate_technologies, dependent: :destroy

    def self.get_5_best_matches_by_experience_city_and_technology(years_experience, city, technology)
        odel.where("name LIKE ? AND last_name LIKE ? AND first_name LIKE ?", "%#{search}%","%#{search}%","%#{search}%")
    end
end
