class AddShoppingListReferenceToShoppingItems < ActiveRecord::Migration
  def change
    add_reference :shopping_items, :shopping_list, index: true
  end
end
