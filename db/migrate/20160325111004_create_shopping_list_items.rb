class CreateShoppingListItems < ActiveRecord::Migration
  def change
    create_table :shopping_list_items do |t|
      t.integer :item_id
      t.integer :shopping_list_id
      t.integer :added_by_id
      t.integer :amount
      t.boolean :bought, default: false, null: false

      t.timestamps null: false
    end
  end
end
