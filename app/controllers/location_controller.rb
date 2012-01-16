class LocationController < ApplicationController
  def index
  	@locations = Location.order(:name).where("name like ?", "#{params[:location_search]}")
  end

end
