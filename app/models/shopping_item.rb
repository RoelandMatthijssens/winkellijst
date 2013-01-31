class ShoppingItem < ActiveRecord::Base
  attr_accessible :amount, :item, :marked

	belongs_to :item
	scope :unmarked, where(marked: false)
	scope :marked, where(marked:true)
end
