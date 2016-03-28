require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  before(:each) do
    @enermis = User.create!(email: "Enermis@fulgens.com", password: "somePass")
    @household = Household.create!(creator: @enermis, name: "sint-truiden")
  end

  it "should have a creator" do
    shopping_list = ShoppingList.create!(creator: @enermis)
    expect(shopping_list.reload.creator).to eq(@enermis)
  end
  it "should require a creator" do
    expect{
      ShoppingList.create!
    }.to raise_error ActiveRecord::RecordInvalid
  end
  it "can belong to a household" do
    shopping_list = ShoppingList.create!(creator: @enermis, household: @household)
    expect(shopping_list.reload.household).to eq(@household)
  end
  it "should not have to belong to a household" do
    expect{
      ShoppingList.create(creator: @enermis, household: nil)
    }.not_to raise_error
  end
  it "should have many shopping list items" do
    shopping_list = ShoppingList.create!(creator: @enermis, household: @household)
    banana = Item.create(name: "banana")
    milk = Item.create!(name: "milk")
    shopping_item1 = ShoppingListItem.create!(item: banana, amount: 3, shopping_list: shopping_list)
    shopping_item2 = ShoppingListItem.create!(item: milk, amount: 1, shopping_list: shopping_list)
    expect(shopping_list.reload.shopping_list_items).to include(shopping_item1, shopping_item2)
  end

  it "should have a creation time" do
    creationTime = DateTime.new(2016, 02, 14, 20, 10, 0)
    shoppingList = ShoppingList.create!(created_at: creationTime, creator: @enermis)
    expect(shoppingList.created_at).to eq(creationTime)
  end
  it "should automatically set the creation time" do
    shoppingList = ShoppingList.create!(creator: @enermis)
    expect(shoppingList.created_at).not_to be_nil
  end

  describe 'a user' do
    it 'should have many shopping lists' do
      shopping_list1 = ShoppingList.create!(creator: @enermis)
      shopping_list2 = ShoppingList.create!(creator: @enermis)
      expect(@enermis.shopping_lists).to include(shopping_list1, shopping_list2)
    end
    it 'should be able to create a shopping list for himself' do
      shopping_list = @enermis.create_shopping_list
      expect(@enermis.shopping_lists).to include(shopping_list)
    end
    it 'should be able to create a shopping list for his household' do
      shopping_list = @enermis.create_shopping_list(@household)
      expect(@enermis.shopping_lists).to include(shopping_list)
      expect(@household.shopping_lists).to include(shopping_list)
    end
    it 'should not be able to create shopping lists for a household he is not a member of' do
      fulgens = User.create!(email: 'fulgens@fulgens.com', password: 'somepass')
      expect{
        fulgens.create_shopping_list(@household)
      }.to raise_error CustomErrors::PermissionError
    end
  end
end
