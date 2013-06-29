class CreateShoppingItems < ActiveRecord::Migration
	def change
		create_table :shopping_items do |t|
			t.integer :amount
			t.references :item

			t.timestamps
		end
	end
end
