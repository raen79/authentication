require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  describe "GET /authentication" do
    it "works! (now write some real specs)" do
      get authentications_path
      expect(response).to have_http_status(200)
    end
  end
end
