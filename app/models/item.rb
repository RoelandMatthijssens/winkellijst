class Item < ActiveRecord::Base
  attr_accessible :price, :name

	has_many :shopping_items, :dependent => :destroy
end
