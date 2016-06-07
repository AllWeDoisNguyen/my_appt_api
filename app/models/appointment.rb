class Appointment < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with AppointmentValidator, on: :create
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
# *********scopes help with indexing the database with just the specific attributes you want**********
# *********the lambda is just starting the function and block of instructions *************
  scope :start_time, lambda { |start_time| where(start_time: start_time)}
  scope :end_time, lambda { |end_time| where(end_time: end_time) }
  scope :first_name, lambda { |first_name| where(:first_name => first_name) }
  scope :last_name, lambda { |last_name| where(:last_name => last_name) }
  scope :full_name, lambda { |full_name| where(:full_name => full_name) }
  scope :on_this_date, lambda { |just_the_day| 
                                  date_request = Time.zone.strptime(just_the_day, "%m/%d/%Y").beginning_of_day + 2000.years
                                  where(day: date_request) }
  scope :within_month, lambda { where(day: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :within_year, lambda { where(day: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year) }
# ------------- End of Indexing scopes ----------------------------------------------

# *********Converting Start and End Time to be able to parse***********************************

  def formatted_to_datetime(appt_session)
    date_and_time = '%m/%d/%Y %H:%M'
    formatted_to_datetime ||= Time.zone.strptime("#{self.public_send(appt_session)}", date_and_time) + 2000.years
# --------appt_session can be appointment start or end as date object to compare to DateTime
  end
# ---- Invokes the method identified by symbol, passing it any arguments specified. 
# --------Unlike send, public_send calls public methods only.
# ------------------------------------------------------------------------------------    
 def date_when(start_time)
    date_when ||= Time.zone.strptime(start_time, '%m/%d/%Y ') + 2000.years
# @appointments = Appointment.where(:start_time => '01/01/01 00:00')  
# p @appointment.day = "2013-11-29T00:00:00+00:00"
  end # ------------=>  Fri, 29 Nov 2013 00:00:00 +0000
# ************************************************************

  def just_the_day_or_hour(index_of_hour_or_date)
    self.start_time.split[index_of_hour_or_date]
  end
# --------just_the_day_or_hour returns---------------------------------------------
# irb(main):002:0> A.just_the_day_or_hour(1)
# => "14:00"
# irb(main):003:0> A.just_the_day_or_hour(0)
# => "11/29/13"

# ----------The set_day method underneath-----------
# saves the appointment day: column as a DateTime object
# 
# Appointment.where(day: "#{DateTime.strptime('11/01/13', '%m/%d/%Y') + 2000.years}")
# returns all appointments with that day

  def set_day=(value)
    self.day = value
    # sets the appt day as date if called 
    # appointment.set_day = appointment.just_the_day(0)
  end

  def full_name
    "#{self.first_name}, #{self.last_name}"
    #=> getter method that returns the first and last name in a string
  end

  def full_name=(value) # should equal the string of the full name user gives
    self.first_name, self.last_name = value.to_s.split(" ", 2)
    # sets first name and last name when someone assigns a full_name
  end
end

