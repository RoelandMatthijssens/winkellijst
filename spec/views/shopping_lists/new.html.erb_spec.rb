require 'spec_helper'

describe "shopping_lists/new" do
  before(:each) do
    assign(:shopping_list, stub_model(ShoppingList).as_new_record)
  end

  it "renders new shopping_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shopping_lists_path, :method => "post" do
    end
  end
end
