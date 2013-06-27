class CreateShoppingItems < ActiveRecord::Migration
	def change
		create_table :shopping_items do |t|
			t.integer :amount
			t.boolean :marked, default: false
			t.references :item
			t.references :shopping_list

			t.timestamps
		end
	end
end
