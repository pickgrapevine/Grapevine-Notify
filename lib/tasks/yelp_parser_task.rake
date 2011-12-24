require_relative "../jobs/yelp"

namespace :parsers do
  desc "Parse Yelp Reviews"
  task :yelp => :environment do
    #Parse All Yelp San Antonio Restaurants
      Yelp::Parser.new.all
  end
end