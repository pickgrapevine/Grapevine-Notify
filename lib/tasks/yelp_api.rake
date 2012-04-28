#require_relative "../jobs/yelp_api"
require_relative "../parser_engine"

namespace :yelpapi do
  desc "Reviews from Yelp API by Location"
  task :yelp_api => :environment do
    #invoke some shit here...
    parser = YelpParser.new
    parser_engine = ParserEngine.new parser
    parser_engine.all
  end
end