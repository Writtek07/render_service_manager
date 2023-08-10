class AddRemoveScheduleToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :schedule_removed, :boolean, default: false
  end
end
