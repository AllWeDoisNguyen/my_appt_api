class Appointment < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with AppointmentValidator, on: :create
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
# *********scopes help with indexing the database with just the specific attributes you want**********
# *********the lambda is just starting the function and block of instructions *************
  # scope :start_time_hour, lambda { |start_time| where(:day => "#{}") } #params[:start_time]
  scope :end_time, lambda { |end_time| where(:end_time => end_time) }
  scope :first_name, lambda { |first_name| where(:first_name => first_name) }
  scope :last_name, lambda { |last_name| where(:last_name => last_name) }
  scope :full_name, lambda { |full_name| where(:full_name => full_name) }
  # scope :date_day, lambda { |day| where(' >= ?', Time.now) }
  scope :on_this_date, lambda { |just_the_day| 
                                  date_request = Time.zone.strptime(just_the_day, "%m/%d/%Y").beginning_of_day + 2000.years
                                  where(day: date_request) }
                                    #[just_the_day, "#{self.start_time.split[1]}"].join(' ').squeeze.(' ')) }
                                  # Time.zone.strptime(just_the_day, '%m/%d/%Y') + 2000.years) }                                  

  scope :within_month, lambda { where(day: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :within_year, lambda { where(day: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year) }
  #param.beginning_of_day..param.end_of_day) }
# --- scopes for the range of appointments to search for
#---------- where(day: "11/01/13")
  #*********Converting Start and End Time to be able to parse***********************************
  def formatted_to_datetime(appt_session)
    date_and_time = '%m/%d/%Y %H:%M'
    formatted_to_datetime ||= Time.zone.strptime("#{self.public_send(appt_session)}", date_and_time) + 2000.years
    # appointment start or end as date object to compare to DateTime
  end

#self.public_send(day) 
#-----public_send(*args) public
# ----class Klass
    #   def hello(*args)
    #     "Hello " + args.join(' ')
    #   end
    # end

    # k = Klass.new
    # k.send :hello, "gentle", "readers" #=> "Hello gentle readers"
    # k.public_send :hello, "gentle", "readers" #=> "Hello gentle readers"
#---- Invokes the method identified by symbol, passing it any arguments specified. 
# --------Unlike send, public_send calls public methods only.
#------- Appointment.
# ?appt_day=11/01/19
#irb(main):002:0> A.start_time
#=> "11/29/13 14:00"
#irb(main):003:0> A.add_day
#=> "11/29/13"
#irb(main):004:0>     
#----------- use as @appointment.start_as_datetime(:add_day) 
 def date_when(start_time)
    date_when ||= Time.zone.strptime(start_time, '%m/%d/%Y ') + 2000.years
# p @appointment.start_time = "11/1/13 07:00 07:05" 
# @appointments = Appointment.where(:start_time => '01/01/01 00:00')  
# p @appointment.day = "2013-11-29T00:00:00+00:00"
# start_time.split[1] = 
  end # ------------=>  Fri, 29 Nov 2013 00:00:00 +0000

  def start_time_comparable_to_Time_now
  start_time_comparable_to_Time_now ||= self.to_date_object(:start_time)
  end
  #************************************************************

  def just_the_day
    self.start_time.split[0]
    #=> gets just the day, ex: "11/01/13"
  end

  # @appointment.where(day: "11/01/13") should return the relation object of 
  # appointments with that day in this string format. The change_day method underneath
  # saves the appointment day column as a DateTime object
  # Appointment.where(day: "#{DateTime.strptime('11/01/13', '%m/%d/%Y') + 2000.years}")
  # returns all appointments with that day


  def set_day=(value)
    self.day = value
    # sets the appt day as date if called as appointment.set_day = appointment.just_the_day
  end

  def full_name
    "#{self.first_name}, #{self.last_name}"
    #=> getter method that returns the first and last name in a string
  end

  def full_name=(value) # should equal the string of the full name user gives
    self.first_name, self.last_name = value.to_s.split(" ", 2)
    # sets first name and last name when someone assigns a full_name
  end

  # def to_param
  #   full_name
  # end

end

