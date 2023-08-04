class ChangeStatusToInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :status
    add_column :services, :status, :integer, :default => 0
    #Ex:- :default =>''
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
