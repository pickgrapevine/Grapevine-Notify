require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.urbanspoon.com/r/39/432569/restaurant/Downtown/Zinc-Bistro-Wine-Bar-San-Antonio"
hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
doc = Nokogiri::HTML(open(url))

puts url, doc.at_css("title").text, "====================="


#doc.css("div.body").each do |review|
 # puts "Author: " + review.css("div.byline a").text
  #puts "Author Location: " + review.css("").text
  #puts "Date Reviewed: " + review.css("")
  #puts "Rating: " + review.css("")
  #puts "Review: " + review.css("").text
#  puts "------------"
#end