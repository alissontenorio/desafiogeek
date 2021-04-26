class CandidateTechnologiesController < ApplicationController
  def technologies
    render :json => CandidateTechnology.distinct.pluck(:name)
  end
end