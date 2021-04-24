class CandidateTechnology < ApplicationRecord
    validates :candidate_id, presence: true
    validates :name, presence: true

    belongs_to :candidate
end
