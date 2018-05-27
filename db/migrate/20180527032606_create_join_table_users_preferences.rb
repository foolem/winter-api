class CreateJoinTableUsersPreferences < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :preferences do |t|
      # t.index [:user_id, :preference_id]
      # t.index [:preference_id, :user_id]
    end
  end
end
