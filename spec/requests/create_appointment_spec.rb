require 'rails_helper'

RSpec.describe "Appointment creation", :type => :request do
  # before :all do
  #   @appointment = FactoryGirl.build(:appointment, start_time: "11/1/17 9:30", 
  #                                   end_time: "11/1/17 9:35", 
  #                                   first_name: "Jude", 
  #                                   last_name: "Blome"))

  #   post "/appointments"
  # end

  it "creates an appointment" do
   
    post "/appointments", {:start_time => "11/1/22 9:30",
                                             :end_time => "11/1/22 9:35",
                                             :first_name => "Jidy",
                                             :last_name => "Blomy",
                                             :day => "11/1/22"} 

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(:created)
    expect(Appointment.find_by(first_name: "Jidy")).to be_a(Appointment)
  end

  it "cannot create appointment with nil start date" do 

    post "/appointments",  {:start_time => nil,
                                            :end_time => "11/1/17 7:35",
                                            :first_name => "Judy",
                                            :last_name => "Blume"} 

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end  

  it "cannot create appointment with nil end date" do 

    post "/appointments",  {:start_time => "11/1/17 7:35",
                                            :end_time => nil,
                                            :first_name => "Judy",
                                            :last_name => "Blume"} 

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end 

  it "cannot create appointment with nil first name" do 

    post "/appointments", {:start_time => "11/1/17 7:30",
                                            :end_time => "11/1/17 7:35",
                                            :first_name => nil,
                                            :last_name => "Blume"} 

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end                                        

 it "cannot create appointment with nil last name" do 

    post "/appointments", {:start_time => "11/1/17 7:30",
                                            :end_time => "11/1/17 7:35",
                                            :first_name => "Judy",
                                            :last_name => nil} 

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end 

  it "cannot create appointment with past start time" do 

    post "/appointments", {:start_time => "01/1/14 7:30",
                                            :end_time => "11/1/17 7:35",
                                            :first_name => "Judy",
                                            :last_name => "Blume"} 

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end 

  it "cannot create appointment with past end time" do 

    post "/appointments", {:start_time => "01/1/17 7:30",
                                            :end_time => "11/1/10 7:35",
                                            :first_name => "Judy",
                                            :last_name => "Blume"} 

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end   

  it "adds start time date to day column" do

    post "/appointments", {:start_time => "01/1/17 7:30",
                                            :end_time => "01/1/17 7:35",
                                            :first_name => "Judy",
                                            :last_name => "Blume"} 

    @appt = Appointment.find_by(start_time: "01/1/17 7:30")
    @appt.set_day = @appt.formatted_to_datetime(:start_time).beginning_of_day      

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(:created)
    expect(@appt).to be_a(Appointment)
    expect(@appt.day).to_not be(nil)
    p @appt
    # expect(Appointment.find_by(start_time: "01/1/17 7:30").day).to be("01/1/17")
  end

end