require_relative "../jobs/yelp"

namespace :parsers do
  desc "Parse Yelp Reviews"
  task :yelp => :environment do
    #Yelp::parse_all_reviews
    Yelp::parse_restaurants_count
    #puts "hello world!"
  end
end