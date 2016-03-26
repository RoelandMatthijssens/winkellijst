require 'rails_helper'

RSpec.describe Store, type: :model do
  it "should have a name" do
    store = Store.create!(name:"Lidl")
    expect(store.name).to eq("Lidl")
  end

  it "should sells many items" do
    lidl = Store.create!(name: "Lidl")
    banana = Item.create!(name: "banana")
    milk = Item.create!(name: "milk")
    lidl.items << banana
    lidl.items << milk
    expect(lidl.items).to include(milk)
    expect(lidl.items).to include(banana)
  end
end
