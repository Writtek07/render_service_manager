class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :service_id
      t.string :status
      t.datetime :custom_start_time
      t.datetime :custom_stop_time

      t.timestamps
    end
  end
end
