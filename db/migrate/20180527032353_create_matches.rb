class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :first_user
      t.boolean :first_like
      t.references :second_user
      t.boolean :second_like

      t.timestamps
    end
  end
end
