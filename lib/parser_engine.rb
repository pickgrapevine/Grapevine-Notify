class ParserEngine
  
  
  def initialize(parser)
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    @parser = parser
  end
  
  def all
    locations = @parser.parse_locations
    current_san_antonio_locations = Location.where("city=:city",{:city=>"San Antonio"}).all #need a parser_identifier
    locations.each do |location|
      found_location = current_san_antonio_locations.find {|l| l==location}
      puts found_location
      if found_location.count == 0
         location.save!
      end
      
      reviews = @parser.parse_all_reviews_for_location(location)
      current_reviews_in_database = Review.where("location_id=?",found_location.id)
      reviews.each do |review|
        found_review = current_reviews_in_database.find review
        if found_location.count == 0
          location.reviews << review
          review.save!
        end
      end
      
    end
  end
end