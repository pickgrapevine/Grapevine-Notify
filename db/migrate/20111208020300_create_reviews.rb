class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :author
      t.string :author_location
      t.string :recommend
      t.integer :rating
      t.text :comment
      t.datetime :date
      t.string :link

      t.timestamps
    end
  end
end
