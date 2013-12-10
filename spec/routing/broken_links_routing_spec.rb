require "spec_helper"

describe BrokenLinksController do
  describe "routing" do

    it "routes to #index" do
      get("/broken_links").should route_to("broken_links#index")
    end

    it "routes to #new" do
      get("/broken_links/new").should route_to("broken_links#new")
    end

    it "routes to #show" do
      get("/broken_links/1").should route_to("broken_links#show", :id => "1")
    end

    it "routes to #edit" do
      get("/broken_links/1/edit").should route_to("broken_links#edit", :id => "1")
    end

    it "routes to #create" do
      post("/broken_links").should route_to("broken_links#create")
    end

    it "routes to #update" do
      put("/broken_links/1").should route_to("broken_links#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/broken_links/1").should route_to("broken_links#destroy", :id => "1")
    end

  end
end
