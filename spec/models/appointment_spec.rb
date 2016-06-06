require 'rails_helper'
require 'factory_girl_rails'


describe Appointment do
  before { @appointment = FactoryGirl.create(:appointment) }

  subject { @appointment }

  # it { should respond_to(:first_name) }
  # it { should respond_to(:last_name) }
  # it { should respond_to(:start_time) }
  # it { should respond_to(:end_time) }

  it { should be_valid }
  it { should be_a(Appointment)}
end