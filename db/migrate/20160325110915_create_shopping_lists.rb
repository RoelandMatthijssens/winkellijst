class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.integer :creator_id
      t.integer :household_id

      t.timestamps null: false
    end
  end
end
