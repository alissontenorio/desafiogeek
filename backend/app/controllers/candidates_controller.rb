class CandidatesController < ApplicationController
  def list_5_best_matches
    #candidates_best_5_matches = Candidate.get_5_best_matches_by_experience_city_and_technology(
    #                params[:years_experience].to_i, Util.get_splitted_city_and_district(params[:city])[0], params[:technologies])
    candidates_best_5_matches = Candidate.get_5_best_matches(params[:years_experience_min].to_i, 
      params[:years_experience_max].to_i, params[:city], params[:technologies].split(','))
    
      candTemp = []
      candidates_best_5_matches.map { |k|
        candTemp << {
          'id' => k['id'],
          'city' => k['city'].split(' - ')[0],
          'district' => k['city'].split(' - ')[1],
          'years_experience' => k['years_experience'],
          'candidate_technologies' => CandidateTechnology.where(candidate_id: k['id'])
                                                            .select(:id, :name, :is_main_tech)
        }
      }
    render :json => candTemp
  end

  def cities
    render :json => Candidate.distinct.pluck(:city, :district).map{|city, district| city + " - " + district}
  end 
end
