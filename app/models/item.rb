class Item < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :stores
  has_many :shopping_list_items

  def is_sold_in?(store)
    return stores.include?(store)
  end
end
