require 'spec_helper'

describe "shopping_lists/index" do
  before(:each) do
    assign(:shopping_lists, [
      stub_model(ShoppingList),
      stub_model(ShoppingList)
    ])
  end

  it "renders a list of shopping_lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
