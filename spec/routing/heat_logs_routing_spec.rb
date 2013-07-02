require "spec_helper"

describe HeatLogsController do
  describe "routing" do

    it "routes to #index" do
      get("/heat_logs").should route_to("heat_logs#index")
    end

    it "routes to #new" do
      get("/heat_logs/new").should route_to("heat_logs#new")
    end

    it "routes to #show" do
      get("/heat_logs/1").should route_to("heat_logs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/heat_logs/1/edit").should route_to("heat_logs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/heat_logs").should route_to("heat_logs#create")
    end

    it "routes to #update" do
      put("/heat_logs/1").should route_to("heat_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/heat_logs/1").should route_to("heat_logs#destroy", :id => "1")
    end

  end
end
