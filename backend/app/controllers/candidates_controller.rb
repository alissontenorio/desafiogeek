class CandidatesController < ApplicationController
  def list_5_best_matches
    @candidates_best_5_matches = Candidate.get_5_best_matches_by_experience_city_and_technology(
      params[:years_experience], params[:city], params[:technology])
    puts @candidates_best_5_matches
  end
end
