require 'rails_helper'

describe "AppointmentValidator" do
  before do
    @existing_appointment = Appointment.new(start_time: "11/30/17 7:30", end_time: "11/30/17 7:35", first_name: "Stanley", last_name: "Man", day: "2017-11-30T07:03:00+00:00")
  end

  it "should validate the start and end time existence" do
    @appointment = Appointment.new(start_time: nil, end_time: "11/30/17 7:35", first_name: "Stanley", last_name: "Man")
    AppointmentValidator.new.validate(@appointment)
    expect(@appointment.errors[:time]).to include("Need a start or end time")
  end

  it "should check if appointment time is in the future" do
    @existing_appointment.save
    @appointment = Appointment.new(start_time: "11/30/12 7:30", end_time: "11/30/12 7:35", first_name: "ba", last_name: "an")
    AppointmentValidator.new.validate(@appointment)
    expect(@appointment.errors[:time]).to include("Appointment must be made in future")
  end

  it "should check if appointment end time conflicts" do
    @existing_appointment.save
    @appointment = Appointment.new(start_time: "11/30/17 6:30", end_time: "11/30/17 7:35", first_name: "Stanley", last_name: "Man")
    AppointmentValidator.new.validate(@appointment)
    expect(@appointment.errors[:time]).to include("Appointment end time cannot be within another appointment")
  end

  it "should check if appointment start time conflicts" do
    @existing_appointment.save
    @appointment = Appointment.new(start_time: "11/30/17 7:31", end_time: "11/30/17 7:36", first_name: "Stanley", last_name: "Man")
    AppointmentValidator.new.validate(@appointment)
    expect(@appointment.errors[:time]).to include("Appointment start time cannot be within another appointment")
  end

  it "should check if appointment overlaps" do
    @existing_appointment.save
    @appointment = Appointment.new(start_time: "11/30/17 7:21", end_time: "11/30/17 7:40", first_name: "Stanley", last_name: "Man")
    AppointmentValidator.new.validate(@appointment)
    expect(@appointment.errors[:time]).to include("Appointment cannot overlap another appointment")
  end
end