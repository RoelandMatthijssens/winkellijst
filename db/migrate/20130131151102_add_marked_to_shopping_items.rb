class AddMarkedToShoppingItems < ActiveRecord::Migration
  def change
    add_column :shopping_items, :marked, :boolean, :default => false
  end
end
