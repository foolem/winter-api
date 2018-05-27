class CreateSubAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_areas do |t|
      t.string :name
      t.references :area, foreign_key: true
      t.references :sub_area, foreign_key: true

      t.timestamps
    end
  end
end
