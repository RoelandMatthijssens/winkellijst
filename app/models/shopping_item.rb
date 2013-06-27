class ShoppingItem < ActiveRecord::Base
  attr_accessible :amount, :item, :marked, :shopping_list

	belongs_to :item
	belongs_to :shopping_list
	scope :unmarked, where(marked: false)
	scope :marked, where(marked:true)
end
