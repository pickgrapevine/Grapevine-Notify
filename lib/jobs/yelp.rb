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
    @san_antonio = parse_satx_locations
    @customers = [{:name=>"El Milagrito",:url=>"/biz/el-milagrito-cafe-san-antonio?rpp=40&sort_by=date_desc&start="}]
  end

  #copied verbatim
  def all
    @san_antonio.each do |sa_biz|
      parse_all_sections(sa_biz)
    end
  end
  
  #currently not implemented in rake task, need walkthrough
  def customers
    @customers.each do |customer|
     parse_all_sections(customer)
     end
  end
  
private

  #TODO: don't use silly browser agent. Try IE or something more common,
  def read_html(url)
      hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
      my_html = ""
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
  def parse_locations_list(index="")
    found_locations = Array.new
    Nokogiri::HTML(open("#{@all_locations_link}#{index}")).css("div.businessresult") do |location|
      title_link = location.css("h4.itemheading a").first
      found = Location.new(:url=>title_link[:href],:name=>title_link.inner_html.sub(/[0-9]*\./,''))
      found_locations << found
    end
    found_locations
  end

  #used to parse all reviews of a location
  def parse_all_sections(location)
    count = parse_review_count(location)
    start_index = 0
    while(start_index < count)
      parse_section(location, start_index)
      start_index = start_index + 40
    end
  end
  
  #used to parse the review count so we now how many pages are available for a review
  #TODO: move all the page count logic to another method which does the math and makes the page concept more explicit
  def parse_review_count(location)
    Nokogiri::HTML(open("http://www.yelp.com#{location.url}")).css("span.review-count span.count").inner_text.to_i
  end
  
  #TODO: rename to parse review
  def parse_section(location, index)
    my_html = read_html "http://www.yelp.com#{location[:url]}=#{index}"
    doc = Nokogiri::HTML(open(my_html))
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
  
  #TODO: this is temporary. should be replaced with a method to parse several locations
  def parse_satx_locations()
    found_locations = Array.new
    job_start_time = Time.now
    count = parse_locations_count
    start_index = 0
    while(start_index  < count)do
      start_parse = Time.now
      parse_locations_list(start_index).each {|found_location| found_locations << found_location }
      puts "parsed index #{start_index} elapsed #{(Time.now - start_parse)}"
      start_index = start_index + 10
    end
    puts "total time to parse restuarant list was #{Time.now - job_start_time}"
    found_locations
  end

end
end