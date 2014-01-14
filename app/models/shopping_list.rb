class ShoppingList < ActiveRecord::Base
  attr_accessible :date, :lock, :removed

	has_many :shopping_items, :dependent => :destroy
	belongs_to :household
	default_scope where(:removed => false)

end
