require 'spec_helper'

describe "households/new" do
  before(:each) do
    assign(:household, stub_model(Household,
      :name => "MyString",
      :password_protected => false,
      :password => "MyString",
      :city => "MyString",
      :postal_code => "MyString",
      :housenumber => 1,
      :housenumber_addition => "MyString",
      :phonenumber => "MyString"
    ).as_new_record)
  end

  it "renders new household form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => households_path, :method => "post" do
      assert_select "input#household_name", :name => "household[name]"
      assert_select "input#household_password_protected", :name => "household[password_protected]"
      assert_select "input#household_password", :name => "household[password]"
      assert_select "input#household_city", :name => "household[city]"
      assert_select "input#household_postal_code", :name => "household[postal_code]"
      assert_select "input#household_housenumber", :name => "household[housenumber]"
      assert_select "input#household_housenumber_addition", :name => "household[housenumber_addition]"
      assert_select "input#household_phonenumber", :name => "household[phonenumber]"
    end
  end
end
