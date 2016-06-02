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
      created = false
    elsif self.to_date(:start_time) > Time.now && self.to_date(:end_time) > Time.now
      created = true
    else
      created = false
    end
    created
  end
end
