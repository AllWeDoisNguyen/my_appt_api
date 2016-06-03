require 'rails_helper'

RSpec.describe "Appointment Update", :type => :request do
  before do 
  @appointment = Appointment.new(start_time: "12/1/19 10:30", end_time: "12/1/19 10:35", first_name: "Jo", last_name: "Blume")
  @appointment.save(validate: false)
  end
  
  it "updates an appointment name" do
    patch "/appointments?first_name=Jo&last_name=Blume", {:appointment => {:last_name => "Bobby"} }
    # patch "/appointments/#{@appointment.id}", {:appointment => {:last_name => "Bobby"} }
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(@appointment.reload.last_name).to eq("Bobby")
  end

  it "updates an appointment time" do
   
    patch "/appointments/#{@appointment.id}", {:appointment => {:start_time => "11/02/17 7:30",
                                                              :end_time => "11/02/17 7:35"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(@appointment.reload.start_time).to eq("11/02/17 7:30")
  end

  it "cannot update a past appointment" do
    
    @appointment = Appointment.new(start_time: "04/05/16 10:30", end_time: "04/05/16 10:30")
    @appointment.save(validate: false)
    patch "/appointments?first_name=Jo", {:appointment => {:last_name => "Bobby"} }
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(200)
    expect(@appointment.reload.start_time).to eq("04/05/16 10:30")
  end


end