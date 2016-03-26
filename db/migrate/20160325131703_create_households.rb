class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.string :name
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
