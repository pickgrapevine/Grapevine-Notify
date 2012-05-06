#API wrapper for Yelp API
require 'rubygems'
require 'oauth'
require 'json'
require 'pp'
#require_relative "../../app/models/review"

class YelpSearchParser

	 def search_for_yelp_id#(location, term, lat, long)
	 	consumer_key = 'CoPn_PDLyBIom28EwW_vcg'
		consumer_secret = 'v6VqDXMzGUpLEnbCGx6xDAwG4OM'
		token = '8UmXzrrFzbAffWuTpjTiOQkiFKJ3KZzY'
		token_secret = 'uADpLMg0_BuzFaTWP3GOie9qIQU'

		api_host = 'api.yelp.com'

		consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
		access_token = OAuth::AccessToken.new(consumer, token, token_secret)

		#path to use in production, accepting location
		#path = "/v2/search?term=#{term}&ll=#{lat},#{long}"

		#path to use while testing/dev
		path = "/v2/search?term=zinc%20bistro%20wine%20bar&ll=29.4236445,-98.48926999999998"

		# Using Ruby JSON
		search = JSON.parse(access_token.get(path).body)

		pp search

		#play with the data
		#location = Array.new

	end

end


