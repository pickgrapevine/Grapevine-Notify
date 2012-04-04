class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone_number_1
      t.string :phone_number_2
      t.string :phone_number_3
      t.string :name
      t.string :url
      t.string :lat
      t.string :long
      t.string :Yelp_ID
      t.string :CityGrid_ID
      t.string :GooglePlaces_ID
      t.string :UrbanSpoon_ID
      t.string :YellowPages_ID
      t.string :TripAdvisor_ID
      t.integer :category_id

      t.timestamps
    end
  end
end