class Appointment < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with AppointmentValidator, on: :create
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  scope :start_time, lambda { |start_time| where(:start_time => start_time) }
  scope :end_time, lambda { |end_time| where(:end_time => end_time) }
  scope :first_name, lambda { |first_name| where(:first_name => first_name) }
  scope :last_name, lambda { |last_name| where(:last_name => last_name) }
  scope :comments, lambda { |comments| where(:comments => comments) }
  scope :full_name, lambda { |full_name| where(:full_name => full_name) }
  scope :day, lambda { where('day >= ?', Time.now) }


  #*********Converting Start and End Time to be able to parse***********************************
  def to_date_object(time)
    to_date_object ||= DateTime.strptime(self.public_send(time), '%m/%d/%Y %H:%M') + 2000.years
    # date object
  end

  def start_as_datetime(day)
    start_as_datetime ||= DateTime.strptime(self.public_send(day), '%m/%d/%Y') + 2000.years
  end

  def start_time_comparable_to_Time_now
  start_time_comparable_to_Time_now ||= self.to_date_object(:start_time)
  end
  #************************************************************

  def day
    self.start_time.split[0]
    #=> gets just the day, ex: "11/01/13"
  end

  def change_day=(value)
    self.day = value
    # sets the appt day as datetime if called as appointment.day = appointment.start_as_datetime(:day)
  end

  def full_name
    "#{self.first_name}, #{self.last_name}"
    #=> getter method that returns the first and last name in a string
  end

  def full_name=(value) # should equal the string of the full name user gives
    self.first_name, self.last_name = value.to_s.split(" ", 2)
    # sets full_name to the full name params
  end

  # def to_param
  #   full_name
  # end


end

