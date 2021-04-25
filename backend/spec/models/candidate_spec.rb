require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe "Testing Candidate Model" do
    subject {
      described_class.new(city: 'Recife', district: 'PE', years_experience: 2)
    }

    it "is valid" do
      expect(subject).to be_valid
    end

    it "is not valid without a city" do      
      subject.city = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a district" do
      subject.district = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without years of expirence" do
      subject.years_experience = nil
      expect(subject).to_not be_valid
    end

    #it "returns correct response from filter"
  end
end
