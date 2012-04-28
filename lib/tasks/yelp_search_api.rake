require_relative "../jobs/yelp_search_api"

namespace :yelp do
  desc "Yelp - Search for Business ID"
  task :search_for_business_id => :environment do
    #invoke some shit here...
    business_id = YelpSearchParser.new
    business_id.search_for_yelp_id
    end
end