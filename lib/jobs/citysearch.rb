require 'rubygems'
require 'httparty'
#httparty works well for non-OAuth restful services
#require 'pp'
require_relative "../../app/models/review"

class CityearchApiParser

	 def parse_all_reviews_for_location(location)
	 	publisher_code = '10000001524'

	 	#use in production when passing location id
	 	#path = "http://api.citygridmedia.com/content/reviews/v2/search/where?publisher=#[publisher_code}&listing_id=#{location}&sort=createdate&rpp=50"

	 	#used to test in development
	 	path = "http://api.citygridmedia.com/content/reviews/v2/search/where?publisher=#{publisher_code}&listing_id=#{location}&sort=createdate&rpp=50"

		business = HTTParty.get(path)

		#play with the data
		reviews = Array.new
		business["results"]["uri"]["reviews"]["review"].each do |review|
			parsed_review = Review.new
			parsed_review.rating = review["review_rating"]
			parsed_review.author = review["review_author"]
			parsed_review.comment = review["review_text"]
			parsed_review.date = review["review_date"]
			reviews << parsed_review
		end
		#pp reviews
	end

end