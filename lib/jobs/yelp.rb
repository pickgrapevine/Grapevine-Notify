require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'
require_relative "../../app/models/review"
require_relative "../../app/models/location"

module Yelp

def self.parse_section(location, index)
  url = "http://www.yelp.com/#{location[:url]}=#{index}"
  doc = Nokogiri::HTML(open(url))
  doc.css("ul li.review").each do |review|
    parsed_review = Review.new
    parsed_review.author = review.css("li.user-name a").text
    parsed_review.author_location = review.css("p.reviewer_info").text
    parsed_review.date = Date.strptime(review.css("em.dtreviewed span").first[:title], "%m/%d/%Y")
    parsed_review.rating = review.css("div.rating .star-img img").first[:title][/[0-9]*\.?[0-9]+/]
    parsed_review.comment = review.css("p.review_comment").text
    parsed_review.save!
  end
end

def self.parse_satx_restaurants()
  job_start_time = Time.now
  page_count = parse_restaurants_count
end

class Parser
  def initialize()
    @all_restaurants_link = "http://www.yelp.com/search?find_loc=San+Antonio%2C+TX&cflt=restaurants#start="
    @san_antonio = Yelp::parse_satx_restaurants
  end

  #copied verbatim
  def all
    @san_antonio.each do |sa_biz|
      parse_all_sections(sa_biz)
    end
  end
    
private
  def parse_review_count(location)
    Nokogiri::HTML(open("http://www.yelp.com#{location.url}")).css("span.review-count span.count").inner_text.to_i
  end

  def parse_restaurants_count
    #had trouble with this section so ended up copying it
    td = Nokogiri::HTML(open(@all_restaurants_link)).search("table.fs_pagination_controls tr td:first-of-type span").first
    td.inner_text.split(' ')[4].to_i
  end

  def parse_all_reviews(location)
    job_start_time = Time.now
    page_count = parse_review_count(location)
    start_index = 0
    while(start_index < page_count)
      Yelp::parse_section(location, start_index)
      start_index = start_index + 40
    end
    puts "This actually f*&king worked"
    puts "Total time to parse this business' reviews was #{Time.now - job_start_time}"
  end

end
end