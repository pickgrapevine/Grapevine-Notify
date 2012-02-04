#HTML parser for OpenTable Reviews
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require_relative "../../app/models/review"


class OpenTableHTMLParser

	def parse_reviews_firstresponsepage_for_location(location)

		url = "http://www.opentable.com/las-ramblas-at-hotel-contessa"
		doc = Nokogiri::HTML(open(url))

		reviews = Array.new
		doc.css("div#BVSubmissionPopupContainer").each do |review|
		  parsed_review = Review.new
		  parsed_review.rating = review.css("div#BVRRRatingOverall_Review_Display div img").first[:title].chars.first
		  parsed_review.author = "OpenTable Diner Since " + review.at_css("span.BVRRValue.BVRRAdditionalField.BVRRAdditionalFieldusercreatedate").text
		  parsed_review.comment = review.at_css("span.BVRRReviewText").text
		  parsed_review.date = review.at_css("span.BVRRValue.BVRRAdditionalFielddinedate").text
		  parsed_review.title = review.at_css("span.BVRRValue.BVRRReviewTitle").text
		  reviews << parsed_review
		end
	end
end