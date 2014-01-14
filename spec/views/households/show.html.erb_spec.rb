require 'spec_helper'

describe "households/show" do
  before(:each) do
    @household = assign(:household, stub_model(Household,
      :name => "Name",
      :password_protected => false,
      :password => "Password",
      :city => "City",
      :postal_code => "Postal Code",
      :housenumber => 1,
      :housenumber_addition => "Housenumber Addition",
      :phonenumber => "Phonenumber"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/false/)
    rendered.should match(/Password/)
    rendered.should match(/City/)
    rendered.should match(/Postal Code/)
    rendered.should match(/1/)
    rendered.should match(/Housenumber Addition/)
    rendered.should match(/Phonenumber/)
  end
end
