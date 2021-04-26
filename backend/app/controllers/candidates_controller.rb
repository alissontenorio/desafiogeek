class CandidatesController < ApplicationController
  def list_5_best_matches
    candidates_best_5_matches = Candidate.get_5_best_matches_by_experience_city_and_technology(
                    params[:years_experience].to_i, params[:city], params[:technologies])
    render :json => candidates_best_5_matches, :except => [:created_at, :updated_at], 
                    :include => { :candidate_technologies => { :except => [:candidate_id, :created_at, :updated_at]}}
  end

  def cities
    render :json => Candidate.distinct.pluck(:city)
  end
end
