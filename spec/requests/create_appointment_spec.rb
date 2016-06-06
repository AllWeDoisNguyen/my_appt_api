require 'rails_helper'

RSpec.describe "Appointment creation", :type => :request do

  it "creates an appointment" do
   
    post "/appointments", {:appointment => {:start_time => "11/1/17 9:30",
                                             :end_time => "11/1/17 9:35",
                                             :first_name => "Jude",
                                             :last_name => "Blome"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(:created)
    expect(Appointment.find_by(first_name: "Jude")).to be_a(Appointment)
  end

  it "cannot create appointment with nil start date" do 

    post "/appointments", {:appointment => {:start_time => nil,
                                            :end_time => "11/1/17 7:35",
                                            :first_name => "Judy",
                                            :last_name => "Blume"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end  

  it "cannot create appointment with nil end date" do 

    post "/appointments", {:appointment => {:start_time => "11/1/17 7:35",
                                            :end_time => nil,
                                            :first_name => "Judy",
                                            :last_name => "Blume"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end 

  it "cannot create appointment with nil first name" do 

    post "/appointments", {:appointment => {:start_time => "11/1/17 7:30",
                                            :end_time => "11/1/17 7:35",
                                            :first_name => nil,
                                            :last_name => "Blume"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end                                        

 it "cannot create appointment with nil last name" do 

    post "/appointments", {:appointment => {:start_time => "11/1/17 7:30",
                                            :end_time => "11/1/17 7:35",
                                            :first_name => "Judy",
                                            :last_name => nil} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end 

  it "cannot create appointment with past start time" do 

    post "/appointments", {:appointment => {:start_time => "01/1/14 7:30",
                                            :end_time => "11/1/17 7:35",
                                            :first_name => "Judy",
                                            :last_name => "Blume"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end 

  it "cannot create appointment with past end time" do 

    post "/appointments", {:appointment => {:start_time => "01/1/17 7:30",
                                            :end_time => "11/1/10 7:35",
                                            :first_name => "Judy",
                                            :last_name => "Blume"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to_not have_http_status(:created)
  end   

  it "adds start time date to day column"

    post "/appointments", {:appointment => {:start_time => "01/1/17 7:30",
                                            :end_time => "11/1/10 7:35",
                                            :first_name => "Judy",
                                            :last_name => "Blume"} }

    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(:created)
    expect(Appointment.find_by(start_time: "01/1/17 7:30")).to be_a(Appointment)
    expect(Appointment.find_by(start_time: "01/1/17 7:30")).to include("day: 01/1/17")

end