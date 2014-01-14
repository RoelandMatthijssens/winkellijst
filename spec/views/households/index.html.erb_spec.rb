require 'spec_helper'

describe "households/index" do
  before(:each) do
    assign(:households, [
      stub_model(Household,
        :name => "Name",
        :password_protected => false,
        :password => "Password",
        :city => "City",
        :postal_code => "Postal Code",
        :housenumber => 1,
        :housenumber_addition => "Housenumber Addition",
        :phonenumber => "Phonenumber"
      ),
      stub_model(Household,
        :name => "Name",
        :password_protected => false,
        :password => "Password",
        :city => "City",
        :postal_code => "Postal Code",
        :housenumber => 1,
        :housenumber_addition => "Housenumber Addition",
        :phonenumber => "Phonenumber"
      )
    ])
  end

  it "renders a list of households" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Postal Code".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Housenumber Addition".to_s, :count => 2
    assert_select "tr>td", :text => "Phonenumber".to_s, :count => 2
  end
end
