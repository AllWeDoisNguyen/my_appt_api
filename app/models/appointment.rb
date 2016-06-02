class Appointment < ActiveRecord::Base
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  include ActiveModel::Validations
  validates_with AppointmentValidator

  #*********Converting Start and End Time to be able to parse***********************************
  def to_date(time)
    to_date ||= DateTime.strptime(self.send(time), '%m/%d/%Y %H:%M') + 2000.years
    # date object
  end
  #************************************************************

  

end

