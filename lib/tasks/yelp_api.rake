require_relative "../jobs/yelp_api"

namespace :yelpapi do
  desc "Reviews from Yelp API by Location"
  task :yelp_api => :environment do
    #invoke some shit here...
  end
end