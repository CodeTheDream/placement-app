class CreateLicensees < ActiveRecord::Migration[5.2]
  def change
    create_table :licensees do |t|
      t.string :facility_name
      t.string :contact_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :county
      t.string :phone
      t.string :fax
      t.timestamps
    end
  end
end
