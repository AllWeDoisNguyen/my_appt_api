require 'rails_helper'

RSpec.describe "Appointment management", :type => :request do

  it "creates an appointment" do
   
    post "/appointments", { :appointment => {:start_time => "11/1/13 7:30",
                                             :end_time => "11/1/13 7:35",
                                             :first_name => "Judy",
                                             :last_name => "Blume"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(:created)
    expect(Appointment.find_by(first_name: "Judy")).to be_a(Appointment)
  end

end