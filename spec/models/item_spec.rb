require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @lidl = Store.create!(name: "Lidl")
    @gb = Store.create!(name: "GB")
  end

  it "should have a name" do
    item = Item.create!(name: "banana")
    expect(item.name).to eq("banana")
  end
  it "should require a name" do
    expect{
      Item.create!(name: nil)
    }.to raise_error ActiveRecord::RecordInvalid
  end
  it "should have a price" do
    item = Item.create!(price: 12.3, name: "banana")
    expect(item.price).to eq(12.3)
  end
  it "can be sold in many stores" do
    item = Item.create!(name: "banana")
    item.stores << @lidl
    item.stores << @gb
    expect(item.stores).to include(@lidl)
    expect(item.stores).to include(@gb)
  end
  it "should verify that it is sold in a store" do
    item = Item.create!(name: "banana")
    item.stores << @lidl
    expect(item.is_sold_in?(@lidl)).to be_truthy
    expect(item.is_sold_in?(@gb)).to be_falsey
  end
end
