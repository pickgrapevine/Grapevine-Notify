require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://sanantonio.citysearch.com/review/10089952"
doc = Nokogiri::HTML(open(url))
count = 1

puts url, doc.at_css("title").text, "====================="

doc.css("div.review").each do |review|
  puts "Review #: " + "#{count}"
  puts "Author: " + review.css("h3 a").text
  puts "Date Reviewed: " + review.css(".ratingReviews h4").text
  puts "Review Title: " + review.css("h2").text
  puts "Rating: " +  review.css("span.big_stars img").attr("alt")#.replace(/[^0-9.]/g, "")
  puts "Review: " + review.css("p").text
  puts "------------"
  count += 1
end