require 'rails_helper'

RSpec.describe CandidateTechnology, type: :model do
  describe "Testing Candidate Model" do
    subject {   
      c = Candidate.create(city: 'Recife', district: 'PE', years_experience: 2)   
      described_class.new(candidate_id: c.id, name: 'Java', is_main_tech: true)
    }

    it "is valid" do
      expect(subject).to be_valid
    end

    it "is not valid without candidate id" do      
      subject.candidate_id = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a name (technology)" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
end
