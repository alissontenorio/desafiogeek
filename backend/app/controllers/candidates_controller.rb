class CandidatesController < ApplicationController
  def list_5_best_matches
    candidates_best_5_matches = Candidate.get_5_best_matches(params[:years_experience_min], 
      params[:years_experience_max], params[:city], params[:technologies])
    
      candTemp = []
      candidates_best_5_matches.map { |k|
        candTemp << {
          'id' => k['id'],
          'city' => k['city'].split(' - ')[0],
          'district' => k['city'].split(' - ')[1],
          'years_experience' => k['years_experience'],
          'candidate_technologies' => CandidateTechnology.where(candidate_id: k['id'])
                                                            .select(:id, :name, :is_main_tech).joins(:technology)
        }
      }
    render :json => candTemp
  end

  def cities
    render :json => Candidate.distinct.pluck(:city, :state).map{|city, state| city + " - " + state}
  end 
end
