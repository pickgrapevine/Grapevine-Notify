require 'rubygems'
require 'oauth'
require 'httparty'
require 'JSON'
#require_relative "../../app/models/location"
#require_relative "../../app/models/review"


consumer_key = 'CoPn_PDLyBIom28EwW_vcg'
consumer_secret = 'v6VqDXMzGUpLEnbCGx6xDAwG4OM'
token = '8UmXzrrFzbAffWuTpjTiOQkiFKJ3KZzY'
token_secret = 'uADpLMg0_BuzFaTWP3GOie9qIQU'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)


path = "/v2/business/las-ramblas-san-antonio"
#path = "/v2/business/#{location.url}"

response = access_token.get(path).body

#using rails activesupport json
#data = ActiveSupport::JSON.decode(response)

#using ruby json 
data = JSON.parse(response)

p data

#play with the data
#reviews = Array.new
#data.each do |review|
#	parsed_review = Review.new
#	#not sure how to implement related location for review in db
#	parsed_review.review_count = review.review_count
#	parsed_review.overallrating = review.rating
#	parsed_review.rating = reviews.rating
#	parsed_review.author = reviews.user.name
#	parsed_review.comment = reviews.excerpt
#	parsed_review.date = reviews.time_created
#	reviews << parsed_review
#end
#p reviews

