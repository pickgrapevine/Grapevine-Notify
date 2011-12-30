require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def setup
    Location.all.each {|l| l.delete}
    Review.all.each { |r| r.delete }
  end
  
  def teardown
  end
  
  test "should save with an association to a review" do
    assert 0 == Review.all.count
    assert 0 == Location.all.count
    
    location = Location.new
    location.name = "hello"
    
    review = Review.new
    review.author = "John Smith"
    
    location.reviews << review
    
    location.save!
    
    all_locations = Location.all
    assert 1 == all_locations.count
    assert "John Smith" == all_locations[0].reviews[0].author
    
    assert 1 == Review.all.count
  end
  
end
