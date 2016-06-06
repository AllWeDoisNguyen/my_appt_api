require 'rails_helper'

RSpec.describe "Appointment Index", :type => :request do
  before :all do
    @appointment = FactoryGirl.create(:appointment, start_time: "12/1/19 10:30", 
                                    end_time: "12/1/19 10:35", 
                                    first_name: "Jo", 
                                    last_name: "Blume")
    @appointment_1 = FactoryGirl.create(:appointment)
    # @appointment_1 = FactoryGirl.create(:appointment_1)
    # @appointment_double_name = FactoryGirl.create(:appointment_double_name)
    # @appointment_double_day = FactoryGirl.create(:appointment_double_day)
    # @appts = FactoryGirl.all
    p @appointment
    p @appointment_1
  end

  it "lists all appointments" do
    get "/appointments"
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(Appointment.find_by(first_name: "Jo")).to be_a(Appointment)
  end 

  it "lists appointments by day" do
    get "/appointments", {:day => '12/01/19'}
    expect(response.headers['Content-Type']).to include("application/json")
    expect(response).to have_http_status(200)
    expect(response.body).to include("#{@appointment.start_time}")
  end

end