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
    shopping_list = ShoppingList.create(creator: @enermis, household: @household)
    expect(shopping_list.reload.household).to eq(@household)
  end
  it "should not have to belong to a household" do
    expect{
      ShoppingList.create(creator: @enermis, household: nil)
    }.not_to raise_error
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
end
