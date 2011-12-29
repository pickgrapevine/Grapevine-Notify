class AddForeignKeyToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :location_id, :integer
  end
end
