class UsersLocations < ActiveRecord::Migration
  def change
    create_table :UsersLocations do |t|
      t.integer :user_id
      t.integer :location_id
      
      t.timestamps
    end
  end
end
