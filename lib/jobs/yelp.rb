require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'
require 'bigdecimal'
require_relative "../../app/models/review"
require_relative "../../app/models/location"

module Yelp

  class Parser
    def initialize()
      @all_locations_link = "http://www.yelp.com/search?find_loc=San+Antonio%2C+TX&cflt=restaurants#start="
      @current_san_antonio_locations = Location.where("city=:city",{:city=>"San Antonio"}).all
      puts "total current locations #{@current_san_antonio_locations.count}"
      @san_antonio = parse_satx_locations
      puts "after parsing satx locations there are #{@san_antonio.count} locations"
      @current_san_antonio_reviews = Review.where("id").all
      puts "after parsing reviews there are #{[@current_san_antonio_reviews.count]} reviews"
      @customers = [{:name=>"El Milagrito",:url=>"/biz/el-milagrito-cafe-san-antonio?rpp=40&sort_by=date_desc&start="}]
    end

    #copied verbatim
    def all
      @san_antonio.each do |sa_biz|
        parse_all_reviews_for_location(sa_biz)
      end
    end

    #currently not implemented in rake task, need walkthrough
    def customers
      @customers.each do |customer|
        parse_all_reviews_for_location(customer)
      end
    end

    private

    #TODO: don't use silly browser agent. Try IE or something more common,
    def read_html(url)
      hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
      my_html = ""
      #puts "url to parse location is #{url}"
      open(url, hdrs).each {|s| my_html << s}
      return my_html
    end

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
      puts "total locations on this page #{locations.count}"
      locations.each do |location|
        title_link = location.css("h4.itemheading a").first
        found = Location.new(:url=>title_link[:href], 
        :name=>title_link.inner_html.sub(/[0-9]*\./,''))
        found_locations << found
      end
      found_locations
    end

    #used to parse all reviews of a location
    def parse_all_reviews_for_location(location)
      count = parse_review_count(location)
      page_index = 0
      while(page_index < count)
        parse_reviews_page(location, page_index)
        page_index = page_index + 40
      end
    end

    #used to parse the review count so we now how many pages are available for a review
    #TODO: move all the page count logic to another method which does the math and makes the page concept more explicit
    def parse_review_count(location)
      Nokogiri::HTML(open("http://www.yelp.com#{location.url}")).css("span.review-count span.count").inner_text.to_i
    end

    #TODO: rename to parse review
    def parse_reviews_page(location, page_index)
      
      my_html = read_html "http://www.yelp.com#{location.url}?rpp=40&sort_by=date_desc&start=#{page_index}"
      doc = Nokogiri::HTML(my_html)
      puts "page_index is #{page_index}"
      if page_index == 0 #TODO: this is horrible please fix me
        street_address = doc.css("span.street-address").first.inner_html
        puts "street address text = #{street_address}"
        street_address_parts = street_address.split("<br>")
        puts "street address parts #{street_address_parts}"
        found = Location.new
        found.url = location.url
        found.name= location.name
        found.address_line_1 = street_address_parts[0].to_s
        found.address_line_2 = street_address_parts[1].to_s
        found.address_line_3 = street_address_parts[2].to_s
        found.city = doc.css("span.locality").text
        found.state = doc.css("span.region").text
        found.zip = doc.css("span.postal-code").text
        found.phone_number_1 = doc.css("span#bizPhone").text
        puts "checking if location #{location.name} is in database"
        save_new_location found
      end
      doc.css("ul li.review").each do |review|
        parsed_review = Review.new
        parsed_review.author = review.css("li.user-name a").text
        parsed_review.author_location = review.css("p.reviewer_info").text
        parsed_review.date = Date.strptime(review.css("em.dtreviewed span").first[:title], "%Y-%m-%d")
        parsed_review.rating = review.css("div.rating .star-img img").first[:title][/[0-9]*\.?[0-9]+/]
        parsed_review.comment = review.css("p.review_comment").text
        puts "checking if review from #{parsed_review.author} is in database"
        save_new_review parsed_review
      end
    end

    #TODO: this is temporary. should be replaced with a method to parse several locations
    def parse_satx_locations()
      found_locations = Array.new
      job_start_time = Time.now
      count = 1
      page_index = 0
      while page_index  < count  do
        start_parse = Time.now
        found_locations << parse_location_page(page_index)
        puts "parsed page #{page_index+1} for satx locations. Time elapsed #{(Time.now - start_parse)}"
        page_index = page_index + 10
      end
      puts "total time to parse restuarant all san antonio locations was #{Time.now - job_start_time}"
      found_locations.flatten
    end

    def save_new_review(review)
      puts "total current reviews #{@current_san_antonio_reviews.count}"
     if !@current_san_antonio_reviews.include? review
        puts "saved new review from #{review.author}"
        review.save!
      end
    end

    def save_new_location(location)
      puts "total current locations #{@current_san_antonio_locations.count}"
     if !@current_san_antonio_locations.include? location
        puts "saved new location #{location.name}"
        location.save!
      end
    end
  end
end