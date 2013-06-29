class AddShoppingListReferenceToShoppingItems < ActiveRecord::Migration
  def change
		add_column :shopping_items, :shopping_list_id, :integer
  end
end
