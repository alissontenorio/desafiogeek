class CandidateTechnology < ApplicationRecord
    validates :candidate_id, presence: true
    validates :name, presence: true
    validates :is_main_tech, presence: true

    belongs_to :candidate
end
