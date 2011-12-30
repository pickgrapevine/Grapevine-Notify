class Review < ActiveRecord::Base
  belongs_to :location, :autosave => true #foreign key - location_id
  
  def == (other_review)
    author == other_review.author \
    && author_location == other_review.author_location \
    && rating == other_review.rating
  end
    
end
