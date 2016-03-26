require 'rails_helper'

RSpec.describe ShoppingListItem, type: :model do
  before(:each) do
    @enermis = User.create!(email: "Enermis@fulgens.com", password: "somePass")
    @banana = Item.create(name: "banana")
    @milk = Item.create!(name: "milk")
    @shopping_list = ShoppingList.create!(creator: @enermis)
  end
  it "should have a shopping item" do
    shopping_list_item = ShoppingListItem.create!()
    shopping_list_item.item = @banana
    expect(shopping_list_item.item).to eq(@banana)
  end

  it "should have an amount" do
    shopping_list_item = ShoppingListItem.create!()
    shopping_list_item.item = @banana
    shopping_list_item.amount = 3
    expect(shopping_list_item.amount).to eq(3)
  end
end
