require 'rails_helper'

RSpec.describe "Appointment Index", :type => :request do
  # before :all do 
  # @appointment = FactoryGirl.create(:appointment, start_time: "12/1/19 10:30", 
  #                                   end_time: "12/1/19 10:35", 
  #                                   first_name: "Jo", 
  #                                   last_name: "Blume")
  # end
  it "lists all appointments" do
    get "/appointments"
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(Appointment.find_by(first_name: "Jo")).to be_a(Appointment)
  end 

  it "lists appointments by day" do
    get "/appointments"
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
  end

end