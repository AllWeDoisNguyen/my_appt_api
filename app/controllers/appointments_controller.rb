class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:update, :destroy, :show]
   
  def index
#-- ex: http://example.com/appointments?date_day=11/1/13&&starts_with=Ruby
# ----------------this creates an anonymous scope and if rendered without params, -------
# -----------------will return all appointments -----------------------------------------
    @appointments = Appointment.where(nil) 
# -------- this will tack on each scope method you would like to filter the appointments-------
# ------------ with the values given to the parameters--------------------------
    search_params(params).each do |key, value|
      @appointments = @appointments.public_send(key, value) if value.present?
# @appointments = Appointment.on_this_date("").starts_with("Ruby") # => All active products whose names start with 'Ruby'
      
    end 
    render json: @appointments, status: 200
  end
# ----     def unavailable
# ----       @products = Product.unscoped.where('status <> ?', 'Available')
    #        render 'index'
    #      end


#     class Product < ActiveRecord::Base
#       default_scope where(:deleted => false)
#       scope :available, where(:status => 'Available')
#     end

#  def available
#    @products = Product.available
#    render 'index'
#  end
            # try day_as_date = Appointment.day=start_time.split[0]
            # day_as_date

    # if @appointments = Appointment.start_time_hour
    #   render json: @appointments, status: 200
    # end
    # if @appointments = Appointment.end_time_hour
    #   render json: @appointments, status: 200
    # end

# all appointments.available 
  # *************************************************************************
  # ********** examples ****************************************************
  # 
  # def attendees
  #   render json: Appointment.where(first_name: params[:name])
  # end
# _______________ Appointment.where( )  
#  def all_day
#    self.beginning_of_day..self.end_of_day
#  end
#  scope :on_day, (lambda do |day|
#                 where(start: day.beginning_of_day..day.end_of_day)
#               end)
# beginning_of_day must be done on a Time object
# if there is a value present for start_time_hour
# run that method with that argument 
  #********************************************************************************
  def create
    appointment = Appointment.new(appointment_params)
      if appointment.save
        appointment.set_day = appointment.formatted_to_datetime(:start_time).beginning_of_day
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
    if @appointment.day > Time.zone.now #cannot update past appointment
        # p 'this means that @appointment is in the future'
      if @appointment.update(appointment_params)
        render json: @appointment, status: 200
      else
        render json: @appointment.errors.full_messages, status:422
      end
    else
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
      params.require(:appointment).permit(:first_name, 
                                          :last_name, 
                                          :start_time, 
                                          :end_time, 
                                          :comments, 
                                          :day, 
                                          :full_name, 
                                          :id)
    end
# -- list of scope methods that can be used for filtering the Appointment list---------
    def search_params(params)
      params.slice(:first_name,         
                    :last_name, 
                    :on_this_date, 
                    :end_time, 
                    :comments, 
                    :day, 
                    :full_name, 
                    :id,
                    :within_month,
                    :within_year)
    end
#-----------------{ a: 1, b: 2, c: 3, d: 4 }.slice(:a, :b)
# -----------------=> {:a=>1, :b=>2}
# ex ?start_time_hour=14:00 (query for all appts at that hour)

    def set_appointment
   


#-------http://www.example.com/?foo=1&boo=octopus
#       then params[:foo] would be "1" and params[:boo] would be "octopus".      
      # sets the appointment to wherever it has the id 

      @appointment = Appointment.find(params[:id])
    end
end
