class AddFullNameToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :full_name, :string
  end
end
