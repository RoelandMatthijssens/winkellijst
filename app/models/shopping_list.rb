class ShoppingList < ActiveRecord::Base
  validates :creator, presence: true

  belongs_to :creator, class_name: 'User'
  belongs_to :household
  has_many :shopping_list_items
end
