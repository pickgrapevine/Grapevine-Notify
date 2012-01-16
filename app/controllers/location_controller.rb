class LocationController < ApplicationController
  def index
  	render json: Location.where("name like lower(?)", "%#{params[:location_search].downcase}%").order(:name)
  end

end
