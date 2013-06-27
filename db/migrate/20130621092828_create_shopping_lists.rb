class CreateShoppingLists < ActiveRecord::Migration
	def change
		create_table :shopping_lists do |t|
			t.date :date
			t.boolean :lock, default: false

			t.timestamps
		end
	end
end
