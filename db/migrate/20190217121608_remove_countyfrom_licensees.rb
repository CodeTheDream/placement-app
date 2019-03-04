class RemoveCountyfromLicensees < ActiveRecord::Migration[5.2]
  def change
    remove_column :licensees, :county, :string
  end
end
