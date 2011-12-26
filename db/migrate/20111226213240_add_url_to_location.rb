class AddUrlToLocation < ActiveRecord::Migration
  def change
    change_table :locations  do |t|
      t.string :url
    end
  end
end
