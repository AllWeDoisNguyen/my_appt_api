class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:update, :destroy, :show]
   
  def index
    # present_to_decade_past = Time.now - 10.years
    # present = Time.now
    # range_of_last_decade = present_to_decade_past..present  
    # p search_params(params)
    @appointment = Appointment.where(nil) #creates an anonymous scope
    search_params(params).each do |key, value|
      @appointment += @appointment.public_send(key, value) if value.present? #public send executes : appointment.first_name, appointment.start_time
    end 
    render json: @appointment, status: 200
  end

  def create
    appointment = Appointment.new(appointment_params)
      if appointment.save
        appointment.add_day = appointment.start_as_datetime(:add_day)
        render json: appointment, status: 201, location: appointment
      else
        render json: appointment.errors[:time], status: 422
      end
  end

  def update
    # p params
    # p '-----------this is params-----------'
    # p @appointment
    # p "---------- this is @appointment after being set by id-------"
    if @appointment.to_date_object(:start_time) > Time.now #cannot update past appointment
        # p 'this means that @appointment is in the future'
      if @appointment.update(appointment_params)
        render json: @appointment, status: 200
      else
        render json: @appointment.errors.full_messages, status:422
      end
    else @appointment.to_date_object(:start_time) <= Time.now
      render json: @appointment.errors.full_messages, status: 422
      # @appointment.errors[:time] << 'cannot update an appointment in the past' 
    end
  end

  def destroy
    @appointment.destroy
    head 204
  end

  private

    def appointment_params
      params.require(:appointment).permit(:first_name, :last_name, :start_time, :end_time, :comments, :day, :full_name, :id)
    end

    def search_params(params)
      params.slice(:first_name, :last_name, :start_time, :end_time, :comments, :day, :full_name, :id)
    end

    def set_appointment
   
      # @appointment = Appointment.where(nil) #creates an anonymous scope
      # search_params(params).each do |key, value| #gives hash of params setting the key and value
      #   @appointment = @appointment.public_send(key, value) if value.present? #public send executes : appointment.first_name, appointment.start_time #key will be full_name
      #   end 
      # # if start_time = params[:start_time]
      #   @appointments = Appointment.where(start_time: start_time)

      # end

      # if end_time = params[:end_time]
      #   @appointments = Appointment.where(end_time: end_time)
      # end
      # @appointments = Appointment.where(appointment_params)
      @appointment = Appointment.find(params[:id])
    end
end
