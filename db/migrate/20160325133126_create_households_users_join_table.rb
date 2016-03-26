class CreateHouseholdsUsersJoinTable < ActiveRecord::Migration
  def change
    create_join_table :households, :users do |t|
      t.index [:household_id, :user_id]
      t.index [:user_id, :household_id]
    end
  end
end
