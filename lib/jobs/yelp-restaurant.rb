require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.yelp.com/biz/zinc-bistro-and-wine-bar-san-antonio"
doc = Nokogiri::HTML(open(url))

puts url, doc.at_css("title").text, "====================="


doc.css("ul li.review").each do |review|
  puts "Author: " + review.css("li.user-name a").text
  puts "Author Location: " + review.css("p.reviewer_info").text #need help here!!!
  puts "Date Reviewed: " + review.css("em.dtreviewed span").first[:title]
  puts "Rating: " + review.css("div.rating .star-img img").first[:title][/[0-9]*\.?[0-9]+/]
  puts "Review: " + review.css("p.review_comment").text
  puts "------------"
end
