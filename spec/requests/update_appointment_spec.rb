require 'rails_helper'

RSpec.describe "Appointment Update", :type => :request do

  it "updates an appointment by name" do
    @appointment = Appointment.create(start_time: "12/2/19 10:30", 
                                      end_time: "12/2/19 10:35", 
                                      first_name: "Jo", 
                                      last_name: "Blume", 
                                      day:"Sun, 01 Dec 2019 10:30:00 +0000")

    p @appointment
    p "---this is the appointment created in update by name ---" 
    #allow user to find appointment by name or day instead of id. This is more efficient for a large database*********
    put "/appointments/#{@appointment.id}", {:last_name => "Bobby"}
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(response.body).to include("Jo")
    expect(@appointment.reload.last_name).to eq("Bobby")
  end

  it "updates an appointment time" do
    @appointment = Appointment.create(start_time: "12/3/19 10:30", end_time: "12/3/19 10:35", first_name: "Jo", last_name: "Be", day:"Sun, 01 Dec 2019 10:30:00 +0000")
   
    patch "/appointments/#{@appointment.id}",  {:start_time => "11/02/17 7:30",
                                                              :end_time => "11/02/17 7:35"} 

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(@appointment.reload.start_time).to eq("11/02/17 7:30")
  end

  it "cannot update a past appointment" do
    
    @appointment = Appointment.new(start_time: "04/05/16 10:30", end_time: "04/05/16 10:30")
    @appointment.set_day = @appointment.formatted_to_datetime(:start_time).beginning_of_day
    @appointment.save(validate: false)
    patch "/appointments/#{@appointment.id}", {:last_name => "Bobby"} 
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(200)
    expect(@appointment.reload.start_time).to eq("04/05/16 10:30")
  end
end