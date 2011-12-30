require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    Location.all.each {|l| l.delete}
    Review.all.each { |r| r.delete }
  end
  
  def teardown
  end
  
  test "should save with an association to a review" do
    assert_equal 0 , Review.all.count
    assert_equal 0, Location.all.count
    
    location = Location.new
    location.name = "hello"
    
    review = Review.new
    review.author = "John Smith"
    location.save!
    location.reviews << review
    review.save!
    
    all_locations = Location.all
    assert_equal 1 , all_locations.count
    assert_equal "John Smith" , all_locations[0].reviews[0].author
    
    assert_equal 1 ,Review.all.count
  end
end
