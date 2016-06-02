require 'rails_helper'

RSpec.describe "Appointment Delete", :type => :request do
  before do 
  @appointment = Appointment.create!(start_time: "11/1/17 7:30", end_time: "11/1/17 7:35", first_name: "Judy", last_name: "Blume")
  end
  it "deletes an appointment" do
   
    delete "/appointments/#{@appointment.id}"
    expect(response).to have_http_status(204)
  end
end