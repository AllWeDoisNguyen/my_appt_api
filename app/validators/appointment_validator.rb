class AppointmentValidator < ActiveModel::Validator

  def validate(appointment)
    @appointment = appointment
    if time_is_not_nil?
      if appointment_time_future?
        @appointments = Appointment.where("day > ?", Time.now - 10.years)
        @appointments.each do |existing_appointment|
          check_if_end_time_conflicts_existing_appt(existing_appointment)
          check_if_start_time_conflicts_existing_appt(existing_appointment)
          appt_overlap_check(existing_appointment)
        end
      end
    end
  end

  def time_is_not_nil?
    if @appointment.start_time.nil? || @appointment.end_time.nil?
      @appointment.errors[:time] << 'Need a start or end time' 
      false
    else
      true
    end
  end

  def appointment_time_future? #***if the appt time is in future check for conflicts
    unless @appointment.to_date_object(:start_time) > Time.now && @appointment.to_date_object(:end_time) > @appointment.to_date_object(:start_time)
      @appointment.errors[:time] << 'Appointment must be made in future'
      false
    else
      true
    end
  end

  def check_if_end_time_conflicts_existing_appt(existing_appointment)  #***if the end time is during any appointment, check the start time*******
    if @appointment.end_time >= existing_appointment.start_time && @appointment.end_time <= existing_appointment.end_time
      @appointment.errors[:time] << 'Appointment end time cannot be within another appointment'
    end
  end

  def check_if_start_time_conflicts_existing_appt(existing_appointment) #****if the start time is during any appointment check if the whole appt overlaps***
    if @appointment.start_time >= existing_appointment.start_time && @appointment.start_time <= existing_appointment.end_time
      @appointment.errors[:time] << 'Appointment start time cannot be within another appointment'
    end
  end

  def appt_overlap_check(existing_appointment) #******if the whole appt overlaps another, return false**************
    if @appointment.start_time <= existing_appointment.start_time && @appointment.end_time >= existing_appointment.end_time
      @appointment.errors[:time] << 'Appointment cannot overlap another appointment'
    end
  end 
end
