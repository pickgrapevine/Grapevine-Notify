require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'
require 'bigdecimal'
require_relative "../../app/models/review"
require_relative "../../app/models/location"
require_relative "../http_parser"

class YelpParser
  include HttpParser

  def initialize()
    @all_locations_link = "http://www.yelp.com/search?find_loc=San+Antonio%2C+TX&cflt=restaurants"
  end

  #used to parse all reviews of a location
  def parse_all_reviews_for_location(location)
    count = parse_review_count(location)
    page_index = 0
    reviews = Array.new
    while(page_index < count)
      reviews << parse_reviews_page(location.url, page_index)
      page_index = page_index + 40
    end
    reviews.flatten
  end

  def parse_locations
    found_locations = Array.new
    job_start_time = Time.now
    count = parse_locations_count
    page_index = 0
    while page_index < 1  do 
      start_parse = Time.now
      found_locations << parse_location_page(page_index)
      puts "parsed page #{page_index+1} for satx locations. Time elapsed #{(Time.now - start_parse)}"
      page_index = page_index + 10
    end
    puts "total time to parse restuarant all san antonio locations was #{Time.now - job_start_time}"
    found_locations.flatten
  end

  private
  #TODO: move to more of a paging concept. Should have a method get "total pages" instead of "get resturaunts count"
  #TODO: rename all references from "resturaunts" to "location"
  def parse_locations_count()
    #had trouble with this section so ended up copying it
    td = Nokogiri::HTML(open(@all_locations_link)).css("table.fs_pagination_controls tr td:first-of-type span").first
    td.inner_text.split(' ')[4].to_i
  end

  #need a walkthrough on how this happens
  # think of index as page if page is zero based (first page is 0, second page is 1 and so on)
  #TODO: rename the variable "index" to a variable named "page"
  def parse_location_page(page_index="")
    found_locations = Array.new
    locations = Nokogiri::HTML(open("#{@all_locations_link}#{page_index}")).css("div.businessresult")
    locations.each do |location|
      title_link = location.css("h4.itemheading a").first
      url = title_link[:href]
      my_html = read_html "http://www.yelp.com#{url}?rpp=10&sort_by=date_desc"
      doc = Nokogiri::HTML(my_html)
      street_address = doc.css("span.street-address").first.inner_html
      puts "street address text = #{street_address}"
      street_address_parts = street_address.split("<br>")
      puts "street address parts #{street_address_parts}"
      found = Location.new
      found.url = url
      found.name= title_link.inner_html.sub(/[0-9]*\./,'')
      found.address_line_1 = street_address_parts[0].to_s
      found.address_line_2 = street_address_parts[1].to_s
      found.address_line_3 = street_address_parts[2].to_s
      found.city = doc.css("span.locality").text
      found.state = doc.css("span.region").text
      found.zip = doc.css("span.postal-code").text
      found.phone_number_1 = doc.css("span#bizPhone").text
      found_locations << found
    end
    found_locations
  end



  #used to parse the review count so we now how many pages are available for a review
  #TODO: move all the page count logic to another method which does the math and makes the page concept more explicit
  def parse_review_count(location)
    Nokogiri::HTML(open("http://www.yelp.com#{location.url}")).css("span.review-count span.count").inner_text.to_i
  end

  #TODO: rename to parse review
  def parse_reviews_page(url, page_index)
    my_html = read_html "http://www.yelp.com#{url}?rpp=40&sort_by=date_desc&start=#{page_index}"
    reviews = Array.new
    doc = Nokogiri::HTML(my_html)
    doc.css("ul li.review").each do |review|
      parsed_review = Review.new
      parsed_review.author = review.css("li.user-name a").text
      parsed_review.author_location = review.css("p.reviewer_info").text
      parsed_review.date = Date.strptime(review.css("em.dtreviewed span").first[:title], "%Y-%m-%d")
      parsed_review.rating = review.css("div.rating .star-img img").first[:title][/[0-9]*\.?[0-9]+/]
      parsed_review.comment = review.css("p.review_comment").text
      reviews << parsed_review
    end
    reviews
  end

end
