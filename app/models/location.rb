class Location < ActiveRecord::Base
  # see http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
  has_many :reviews , :autosave => true
  has_and_belongs_to_many :users
  belongs_to :category
   
  def self.search(location_search)
    if search
      find(:name)
    else
      find(:all)
    end
  end

  def == (other_location)
    address_line_1 == other_location.address_line_1 \
    && address_line_2 == other_location.address_line_2 \
    && address_line_3 == other_location.address_line_3 \
    && zip == other_location.zip \
    && name == other_location.name \
    && phone_number_1 == other_location.phone_number_1 \
    && phone_number_2 == other_location.phone_number_2 \
    && phone_number_3 == other_location.phone_number_3 
  end
  
 
  
end
