require 'rails_helper'

RSpec.describe "Appointment Index", :type => :request do
  before do 
  @appointment = Appointment.create(start_time: "12/1/19 10:30", end_time: "12/1/19 10:35", first_name: "Jo", last_name: "Blume", day:"01 Dec 2019 10:30:00 +0000")
  end
  it "lists all appointments" do
    get "/appointments"
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
  end 

  it "lists appointments by day" do
    get "/appointments"
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
  end

end