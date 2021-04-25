require 'rails_helper'

RSpec.describe CandidatesController, type: :controller do 
  # ex: http://127.0.0.1:3000/candidates/list_best_matches/1/Blumenau/Java 
  describe "GET #list_5_best_matches" do
    let(:params1) { {
      :years_experience => 2, 
      :city => 'Recife', 
      :technology => 'Java'
    } }    

    before do
      c = Candidate.create(city: 'Recife', district: 'PE', years_experience: 2)
      c.candidate_technologies.create(name: 'Java', is_main_tech: true)   
    end

    it "returns a success response" do  
      get :list_5_best_matches, params: params1
      expect(response).to be_successful
    end

    it "returns a response which was expected for this filter" do   
      expected = {
        "city" => "Recife",
        "district" => "PE",
        "years_experience" => 2, 
        "candidate_technologies" => [
          {
            "name" => "Java",
            "is_main_tech" => true
          }
        ]
      }
      get :list_5_best_matches, params: params1
      # response_id_excluded = JSON.parse(response.body)
      # response_id_excluded = response_id_excluded.as_json(:except => "id").first
      response_id_excluded = JSON(response.body).as_json(:except => "id").first
      expect(response_id_excluded).to eq(expected)
    end
  end
end


