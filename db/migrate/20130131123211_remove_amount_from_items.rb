class RemoveAmountFromItems < ActiveRecord::Migration
  def up
    remove_column :items, :amount
  end

  def down
    add_column :items, :amount, :integer
  end
end
