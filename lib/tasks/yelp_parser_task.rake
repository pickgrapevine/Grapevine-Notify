require_relative "../jobs/yelp"

namespace :parsers do
  desc "Parse Yelp Reviews"
  task :yelp => :environment do
    Yelp::parse_all_reviews
    #puts "hello world!"
  end
end