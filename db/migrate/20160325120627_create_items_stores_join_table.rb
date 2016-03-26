class CreateItemsStoresJoinTable < ActiveRecord::Migration
  def change
    create_join_table :items, :stores do |t|
      t.index [:item_id, :store_id]
      t.index [:store_id, :item_id]
    end
  end
end
