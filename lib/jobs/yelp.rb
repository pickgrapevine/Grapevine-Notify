require 'rubygems'
require 'nokogiri'
require 'open-uri'
#require 'date'
#require 'chronic'
require_relative "../../app/models/review"

#not understanding all the arguments

module Yelp

def self.parse_all_reviews
  job_start_time = Time.now
  page_count = Yelp::parse_review_count
  start_index = 0
  while(start_index < page_count)
    Yelp::parse_section(start_index)
    start_index = start_index + 40
  end
  puts "This is actually f*&king worked"
  puts "Total time to parse this business was #{Time.now - job_start_time}"
end

def self.parse_review_count
  Nokogiri::HTML(open("http://www.yelp.com/biz/zinc-bistro-and-wine-bar-san-antonio?rpp=40&sort_by=date_desc&start=")).css("span.review-count span.count").inner_text.to_i
end

def self.parse_section(index)
  url = "http://www.yelp.com/biz/zinc-bistro-and-wine-bar-san-antonio?rpp=40&sort_by=date_desc&start=#{index}"
  doc = Nokogiri::HTML(open(url))
  doc.css("ul li.review").each do |review|
    parsed_review = Review.new
    parsed_review.author = review.css("li.user-name a").text
    parsed_review.author_location = review.css("p.reviewer_info").text
    parsed_review.date = review.css("em.dtreviewed span").first[:title]
    parsed_review.rating = review.css("div.rating .star-img img").first[:title][/[0-9]*\.?[0-9]+/]
    parsed_review.comment = review.css("p.review_comment").text
    parsed_review.save!
  end
end

end


