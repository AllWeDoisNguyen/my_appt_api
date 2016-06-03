class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:update, :destroy]
   
  def index
    # present_to_decade_past = Time.now - 10.years
    # present = Time.now
    # range_of_last_decade = present_to_decade_past..present  
    @appointment = Appointment.where(nil)
    search_params(params).each do |key, value|
      @appointment = @appointment.public_send(key, value) if value.present?
    end 
    render json: @appointment, status: 200
  end

  def create
    appointment = Appointment.new(appointment_params)
      if appointment.save
        render json: appointment, status: 201, location: appointment
      else
        render json: appointment.errors[:time], status: 422
      end
  end

  def update
    if @appointment.to_date(:start_time) > Time.now
      if @appointment.update(appointment_params)
        render json: @appointment, status: 200
      else
        render json: @appointment.errors, status:422
      end
    else @appointment.to_date(:start_time) < Time.now
      render json: @appointment.errors, status: 422
    end
  end

  def destroy
    @appointment.destroy
    head 204
  end

  private

    def appointment_params
      params.require(:appointment).permit(:first_name, :last_name, :start_time, :end_time, :comments)
    end

    def search_params(params)
      params.slice(:first_name, :last_name, :start_time, :end_time, :comments)
    end

    def set_appointment
      # if start_time = params[:start_time]
      #   @appointments = Appointment.where(start_time: start_time)

      # end

      # if end_time = params[:end_time]
      #   @appointments = Appointment.where(end_time: end_time)
      # end
      # @appointments = Appointment.where(appointment_params)
      @appointments = Appointment.find(params[:id])
    end
end
