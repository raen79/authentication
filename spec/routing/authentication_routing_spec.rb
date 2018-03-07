require "rails_helper"

RSpec.describe AuthenticationController, type: :routing do
  describe "routing" do

    it "routes to #login" do
      expect(:post => "/api/authentication/login").to route_to("authentication#login")
    end


    it "routes to #register" do
      expect(:post => "/api/authentication/register").to route_to("authentication#register")
    end

    it "routes to #verify_token" do
      expect(:put => "/api/authentication/verify_token").to route_to("authentication#verify_token")
    end
  end
end
