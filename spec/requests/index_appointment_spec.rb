require 'rails_helper'

RSpec.describe "Appointment Index", :type => :request do
it "it lists appointments" do
    get "/appointments"
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
  end

end