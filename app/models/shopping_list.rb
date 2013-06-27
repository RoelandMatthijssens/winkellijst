class ShoppingList < ActiveRecord::Base
  attr_accessible :date, :lock

	has_many :shopping_items, :dependent => :destroy
end
