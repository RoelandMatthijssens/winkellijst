class Item < ActiveRecord::Base
	attr_accessible :price, :name

	has_many :shopping_items, :dependent => :destroy
	
	def self.search(search)
		if search
			where("name LIKE ?", "%#{search}%")
		else
			scoped
		end
	end
end
