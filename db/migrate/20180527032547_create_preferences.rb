class CreatePreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :preferences do |t|
      t.references :sub_area, foreign_key: true
      t.references :creator
      t.string :content

      t.timestamps
    end
  end
end
