require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://maps.google.com/maps/place?cid=1529215561850476287&view=feature&mcsrc=google_reviews&num=20&start=0"
doc = Nokogiri::HTML(open(url))
count = 1

puts url, doc.at_css("title").text, "====================="

doc.css("#pp-reviews-container div.pp-story-item").each do |review|
  puts "Review #: " + "#{count}"
  puts "Author: " + review.css(".pp-review-author span").text
  #No Author Location for Google Places
  puts "Date Reviewed: " + review.css(".date:last").text
  puts "Review Title: " + review.css(".review span.title").text
  #puts "Rating: " +  (review.css(".rsw-half-starred").length * 0.5) + review.css(".rsw-starred").length
  puts "Review: " + review.css(".review span.snippet").text
  puts "------------"
  count += 1
end