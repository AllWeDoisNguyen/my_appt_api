class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:update, :destroy]
   
  def index

      if params[:first_name]
        @appointment = Appointment.find_by(first_name: params[:first_name])
        @appointments = Appointment.where(first_name: @appointment.first_name)
      end

      if params[:last_name]
        @appointment = Appointment.find_by(last_name: params[:last_name])
        @appointments = Appointment.where(last_name: @appointment.last_name)
      end
    render json: @appointments, status: 200
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
    if @appointment.update(appointment_params)
      render json: @appointment, status: 200
    else
      render json: @appointment.errors, status:422
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

    def set_appointment
      # if start_time = params[:start_time]
      #   @appointments = Appointment.where(start_time: start_time)

      # end

      # if end_time = params[:end_time]
      #   @appointments = Appointment.where(end_time: end_time)
      # end
      @appointment = Appointment.find(params[:id])
    end
end
