class AddDayToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :day, :string
  end
end
