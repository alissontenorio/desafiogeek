Rails.application.routes.draw do
  get 'candidates/list_best_matches/:years_experience/:city/:technology', to: 'candidates#list_5_best_matches', as: 'list_best_matches'
end
