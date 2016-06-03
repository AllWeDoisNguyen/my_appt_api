class Appointment < ActiveRecord::Base
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  include ActiveModel::Validations
  validates_with AppointmentValidator
  scope :start_time, -> (start_time) { where start_time: start_time }
  scope :end_time, -> (end_time) { where end_time: end_time }
  scope :first_name, -> (first_name) { where first_name: first_name }
  scope :last_name, -> (last_name) { where last_name: last_name }
  scope :comments, -> (comments) { where comments: comments }


  #*********Converting Start and End Time to be able to parse***********************************
  def to_date(time)
    to_date ||= DateTime.strptime(self.public_send(time), '%m/%d/%Y %H:%M') + 2000.years
    # date object
  end

  def start_time_comparable_to_Time_now
  start_time_comparable_to_Time_now ||= self.to_date(:start_time)
  end
  #************************************************************

  

end

