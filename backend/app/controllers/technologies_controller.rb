class TechnologiesController < ApplicationController
  def technologies
    render :json => Technology.pluck(:name)
  end  
end