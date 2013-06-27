require 'spec_helper'

describe "shopping_lists/edit" do
  before(:each) do
    @shopping_list = assign(:shopping_list, stub_model(ShoppingList))
  end

  it "renders the edit shopping_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shopping_lists_path(@shopping_list), :method => "post" do
    end
  end
end
