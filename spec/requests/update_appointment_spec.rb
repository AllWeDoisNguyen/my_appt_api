require 'rails_helper'

RSpec.describe "Appointment Update", :type => :request do
  before do 
  @appointment = Appointment.create!(start_time: "11/1/17 7:30", end_time: "11/1/17 7:35", first_name: "Judy", last_name: "Blume")
  end
  it "updates an appointment name" do
   
    patch "/appointments/#{@appointment.id}", {:appointment => {:last_name => "Bobby"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(@appointment.reload.last_name).to eq("Bobby")
  end

  it "updates an appointment time" do
   
    put "/appointments/#{@appointment.id}", {:appointment => {:start_time => "11/02/17 7:30",
                                                              :end_time => "11/02/17 7:35"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(@appointment.reload.start_time).to eq("11/02/17 7:30")
  end

end