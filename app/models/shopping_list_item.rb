class ShoppingListItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :shopping_list
  belongs_to :added_by, class_name: 'User'

  validates :item, presence: true
  validates :shopping_list, presence: true

  def self.add_to_shopping_list_item(shopping_list, item, amount, user)
    shopping_list_item = self.get_shopping_list_item(shopping_list, item)
    shopping_list_item.amount += amount
    shopping_list_item.added_by = user
    shopping_list_item.save!
  end

  private
  def self.get_shopping_list_item(shopping_list, item)
    shopping_list_items = self.where(shopping_list:shopping_list).where(item:item)
    if shopping_list_items.empty?
      shopping_list_items << self.create!(item: item, shopping_list: shopping_list, amount:0)
    end
    return shopping_list_items.first
  end
end
