class AppointmentValidator < ActiveModel::Validator

  def validate(appointment)
    @appointment = appointment
    if @appointment.start_time.nil? || @appointment.end_time.nil?
      @appointment.errors[:time] << 'Need a start or end time'
    end
    check_if_appointment_is_future_time
  end

  def check_if_appointment_is_future_time #***if the appt time is in future check for conflicts
    if @appointment.to_date(:start_time) < Time.now && @appointment.to_date(:end_time) < Time.now
      check_if_end_time_conflicts_existing_appt
    else
      @appointment.errors[:time] << 'Appointment cannot be made in the past'
    end
  end

  def check_if_end_time_conflicts_existing_appt  #***if the end time is during any appointment, check the start time*******
    @appointments = Appointment.all
    @appointments.each do |existing_appointment|
      unless @appointment.end_time >= existing_appointment.start_time && @appointment.end_time <= existing_appointment.end_time
        check_if_start_time_conflicts_existing_appt
      else
        @appointment.errors[:time] << 'Appointment end time cannot be within another appointment'
      end
    end
  end

  def check_if_start_time_conflicts_existing_appt #****if the start time is during any appointment check if the whole appt overlaps***
    unless @appointment.start_time >= existing_appointment.start_time && @appointment.start_time <= existing_appointment.end_time
      appt_overlap_check
    else
      @appointment.errors[:time] << 'Appointment start time cannot be within another appointment'
    end
  end

  def appt_overlap_check #******if the whole appt overlaps another, return false**************
    if @appointment.start_time <= existing_appointment.start_time && @appointment.end_time >= existing_appointment.end_time
      @appointment.errors[:time] << 'Appointment start time cannot conflict another appointment'
    end
  end 
end
