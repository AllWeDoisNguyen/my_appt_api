class Appointment < ActiveRecord::Base
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  #*********Converting Start and End Time to be able to parse***********************************
  def to_date(time)
    to_date ||= DateTime.strptime(self.send(time), '%m/%d/%Y %H:%M') + 2000.years
    # date object
  end
  #************************************************************

  def valid
    if self.start_time.nil? || self.end_time.nil?
      can_create = false
    else
      can_create ||= is_future_time
    end
  end


  def is_future_time #***if the appt time is in future check for conflicts
    if self.to_date(:start_time) < Time.now && self.to_date(:end_time) < Time.now
      end_time_check
    end
    else
      false
    end
  end

  def end_time_check  #***if the end time is during any appointment, check the start time*******
    @appointments = Appointment.all
    @appointments.each do |appointment|
      unless self.end_time >= appointment.start_time && self.end_time <= appointment.end_time
        start_time_check
      end
    end
  end

  def start_time_check #****if the start time is during any appointment check if the whole appt overlaps***
    unless self.start_time >= appointment.start_time && self.start_time <= appointment.end_time
      appt_over_check
    end
  end


  def appt_over_check #******if the whole appt overlaps another, return false**************
    if self.start_time <= appointment.start_time && self.end_time >= appointment.end_time
      can_create = false
    else
      can_create = true
    end
    can_create
  end

end

