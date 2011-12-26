class Location < ActiveRecord::Base
  
  def == (other_location)
    address_line_1 == other_location.address_line_1 \
    && address_line_2 == other_location.address_line_2 \
    && address_line_3 == other_location.address_line_3 \
    && zip == other_location.zip \
    && name == other_location.name
  end
  
end
