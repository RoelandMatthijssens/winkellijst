require "spec_helper"

describe ShoppingItemsController do
  describe "routing" do

    it "routes to #index" do
		get("/shopping_items").should route_to("shopping_items#index")
    end

    it "routes to #new" do
      get("/shopping_items/new").should route_to("shopping_items#new")
    end

    it "routes to #show" do
      get("/shopping_items/1").should route_to("shopping_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/shopping_items/1/edit").should route_to("shopping_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/shopping_items").should route_to("shopping_items#create")
    end

    it "routes to #update" do
      put("/shopping_items/1").should route_to("shopping_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/shopping_items/1").should route_to("shopping_items#destroy", :id => "1")
    end

  end
end
