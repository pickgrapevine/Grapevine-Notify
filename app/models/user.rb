class User < ActiveRecord::Base
	has_many :locations
	has_and_belongs_to_many :locations
end
