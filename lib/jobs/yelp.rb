require 'rubygems'
require 'nokogiri'
require 'open-uri'
require_relative "../../lib/location"
require_relative "../../lib/review"

module Yelp

#def self.read_html(url)
 # hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
  #my_html = ""
  #open(url, hdrs).each {|s| my_html << s} #need help understanding this
  #return my_html #need some help
#end

#def self.parse_section(location, index)
  #my_html = read_html "http://yelp.com#{location[:url]}=#{index}" #need help understanding
  testurl = "http://www.yelp.com/biz/zinc-bistro-and-wine-bar-san-antonio"
  doc = Nokogiri::HTML(open(testurl))
  puts testurl
  doc.css("ul li.review").each do |review|
    parsed_review = Review.new
    parsed_review.author = review.css("li.user-name a").text
    parsed_review.author_location = review.css("p.reviewer_info").text
    parsed_review.date = review.css("em.dtreviewed span").first[:title]
    parsed_review.rating = review.css("div.rating .star-img img").first[:title][/[0-9]*\.?[0-9]+/]
    parsed_review.comment = review.css("p.review_comment").text
    parsed_review.save!
    
  end
#end

end

  #http://www.yelp.com/biz/zinc-bistro-and-wine-bar-san-antonio
  #baby steps son
  #puts "Author: " + review.css("li.user-name a").text
  #puts "Author Location: " + review.css("p.reviewer_info").text #need help here!!!
  #puts "Date Reviewed: " + review.css("em.dtreviewed span").first[:title]
  #puts "Rating: " + review.css("div.rating .star-img img").first[:title][/[0-9]*\.?[0-9]+/]
  #puts "Review: " + review.css("p.review_comment").text
  #puts "------------"