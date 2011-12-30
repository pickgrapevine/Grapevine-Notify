require_relative "../jobs/yelp"
require_relative "../parser_engine"

namespace :parsers do
  desc "Parse Yelp Reviews"
  task :yelp => :environment do
    #Parse All Yelp San Antonio Restaurants
    parser = YelpParser.new
    parser_engine = ParserEngine.new parser
    parser_engine.all
  end
end