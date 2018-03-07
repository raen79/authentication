require "rails_helper"

RSpec.describe AuthenticationController, type: :routing do
  describe "routing" do

    it "routes to #login" do
      expect(:post => "/login").to route_to("authentication#index")
    end


    it "routes to #register" do
      expect(:post => "/register").to route_to("authentication#register")
    end

    it "routes to #refresh_token" do
      expect(:put => "/refresh_token").to route_to("authentication#refresh_token")
    end
  end
end
