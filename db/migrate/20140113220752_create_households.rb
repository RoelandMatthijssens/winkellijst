class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.string :name
      t.boolean :password_protected
      t.string :password
      t.string :city
      t.string :postal_code
      t.string :street
      t.integer :housenumber
      t.string :housenumber_addition
      t.string :phonenumber

      t.timestamps
    end
  end
end
