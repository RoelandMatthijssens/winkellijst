require "spec_helper"

describe HouseholdsController do
  describe "routing" do

    it "routes to #index" do
      get("/households").should route_to("households#index")
    end

    it "routes to #new" do
      get("/households/new").should route_to("households#new")
    end

    it "routes to #show" do
      get("/households/1").should route_to("households#show", :id => "1")
    end

    it "routes to #edit" do
      get("/households/1/edit").should route_to("households#edit", :id => "1")
    end

    it "routes to #create" do
      post("/households").should route_to("households#create")
    end

    it "routes to #update" do
      put("/households/1").should route_to("households#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/households/1").should route_to("households#destroy", :id => "1")
    end

  end
end
