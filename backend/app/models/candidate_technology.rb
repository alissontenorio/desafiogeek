class CandidateTechnology < ApplicationRecord
    validates :candidate_id, presence: true
    validates :technology_id, presence: true

    belongs_to :candidate
    belongs_to :technology
end
