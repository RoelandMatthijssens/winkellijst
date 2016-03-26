class ShoppingList < ActiveRecord::Base
  validates :creator, presence: true

  belongs_to :creator, class_name: 'User'
  belongs_to :household
end
