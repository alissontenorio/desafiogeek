Rails.application.routes.draw do
  get 'candidates/list_best_matches', 
        to: 'candidates#list_5_best_matches', as: 'list_best_matches'
  
  get 'candidates/cities', to: 'candidates#cities'
  get 'candidate_technologies', to: 'candidate_technologies#technologies'
end
