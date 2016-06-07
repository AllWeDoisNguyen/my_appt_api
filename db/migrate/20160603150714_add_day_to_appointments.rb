class AddDayToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :day, :datetime
  end
end
