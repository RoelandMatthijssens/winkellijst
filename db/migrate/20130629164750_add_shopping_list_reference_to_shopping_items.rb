class AddShoppingListReferenceToShoppingItems < ActiveRecord::Migration
  def change
    add_column :shopping_items, :shopping_list, :reference
  end
end
