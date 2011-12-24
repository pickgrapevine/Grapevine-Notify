require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'
require 'bigdecimal'
require_relative "../../app/models/review"
require_relative "../../app/models/location"

module Yelp
  
def self.read_html(url)
    hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
    my_html = ""
    open(url, hdrs).each {|s| my_html << s}
    return my_html
end  

def self.parse_section(location, index)
  my_html = read_html "http://www.yelp.com/#{location[:url]}=#{index}"
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

def self.parse_satx_restaurants()
  found_restaurants = Array.new
  job_start_time = Time.now
  count = parse_restaurants_count
  start_index = 0
  while(start_index  < count)do
    start_parse = Time.now
    found_restaurants << parse_restaurants_list(start_index)
    puts "parsed index #{start_index} elapsed #{(Time.now - start_parse)}"
    start_index = start_index + 10
  end
  puts "total time to parse restuarant list was #{Time.now - job_start_time}"
  found_restaurants
end

class Parser
  def initialize()
    @all_restaurants_link = "http://www.yelp.com/search?find_loc=San+Antonio%2C+TX&cflt=restaurants#start="
    @san_antonio = Yelp::parse_satx_restaurants
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
  #need a walkthrough on how this happens
  def parse_restaurants_list(index="")
    found_restaurants = Array.new
    Nokogiri::HTML(open("#{@all_restaurants_link}#{index}")).css("div.businessresult") do |location|
      title_link = location.css("h4.itemheading a").first
      found = Location.new(:url=>title_link[:href],:name=>title_link.inner_html.sub(/[0-9]*\./,''))
      found_restaurants << found
    end
    found_restaurants
  end

  def parse_restaurants_count()
    #had trouble with this section so ended up copying it
    td = Nokogiri::HTML(open(@all_restaurants_link)).css("table.fs_pagination_controls tr td:first-of-type span").first
    td.inner_text.split(' ')[4].to_i
  end

  def parse_review_count(location)
    Nokogiri::HTML(open("http://www.yelp.com#{location.url}")).css("span.review-count span.count").inner_text.to_i
  end

  def parse_all_sections(location)
    count = parse_review_count(location)
    start_index = 0
    while(start_index < count)
      Yelp::parse_section(location, start_index)
      start_index = start_index + 40
    end
  end

end
end