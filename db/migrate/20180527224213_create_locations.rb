class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :logitude
      t.string :city
      t.string :country
      t.string :state

      t.timestamps
    end
  end
end
