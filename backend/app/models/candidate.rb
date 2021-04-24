class Candidate < ApplicationRecord
    validates :city, presence: true
    validates :district, presence: true
    validates :years_experience, presence: true

    has_many :candidate_technologies, dependent: :destroy

    def self.get_5_best_matches_by_experience_city_and_technology(years_experience, city, technology)
        # todo vai receber uma lista de tecnologias ao invés de apenas uma
        c = Candidate.where("years_experience >= ? AND LOWER(city) = ?", years_experience, city.downcase)
                    .joins(:candidate_technologies).where("name = ? AND is_main_tech = ?", technology, true)    
        c.limit(5)     
    end
end
