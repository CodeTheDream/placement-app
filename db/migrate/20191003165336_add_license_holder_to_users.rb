class AddLicenseHolderToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :license_holder, :boolean, default: false
  end
end
