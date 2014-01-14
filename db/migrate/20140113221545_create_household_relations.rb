class CreateHouseholdRelations < ActiveRecord::Migration
	def change
		create_table :households_users do |t|
			t.belongs_to :household
			t.belongs_to :user
		end

		add_column :shopping_lists, :household_id, :integer
	end
end
