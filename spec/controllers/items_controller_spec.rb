require 'spec_helper'
describe ItemsController do
	before(:each) do
		@item = FactoryGirl.create("item")
		@attr = {name:"Name", price:"1.5" }
	end
	it "should update attributes" do
		@item = FactoryGirl.create("item")
		put :update, :id => @item.id, :item => @attr
		@item.reload
		@item.name.should == "Name"
	end
	it "should redirect to index" do
		put :update, :id => @item.id
		response.should redirect_to(items_path)
	end
end
