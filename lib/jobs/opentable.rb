require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.opentable.com/las-ramblas-at-hotel-contessa"
doc = Nokogiri::HTML(open(url))

puts url, doc.at_css("title").text, "====================="

doc.css("div#BVRRDisplayContentBodyID.BVRRDisplayContentBody").each do |review|
  puts "hello"
  #puts "Author: " + review.css("BVRRCustomOTNickname").text
  #puts "Date Reviewed: " + review.css("BVRRAdditionalFielddinedate").text
  puts "Review Title: " + review.at_css("span.BVRRValue.BVRRReviewTitle").text
  #puts "Rating: " +  review.css("BVRRRatingNormalImage img").attr("alt").first#.replace(/[^0-9.]/g, "")
  #puts "Review: " + review.css("BVRRReviewText").text
end