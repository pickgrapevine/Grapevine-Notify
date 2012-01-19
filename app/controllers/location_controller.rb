class LocationController < ApplicationController
  def index
    #TODO: good refactoring opportunity on the map call here
  	render json: Location.where("name like lower(?)", "%#{params[:term].downcase}%")\
  	  .order(:name)\
  	  .map {|l| Hash[ id: l.id, address_line_1: l.address_line_1 , address_line_2: l.address_line_2, label: l.name, name: l.name]}
  end

end
