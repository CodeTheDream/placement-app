class CreatePlacements < ActiveRecord::Migration[5.2]
  def change
    create_table :placements do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :county
      t.string :phone
      t.integer :licensee_id
      t.integer :service_id
      t.string :gender
      t.integer :beds
      t.timestamps
    end
    
    
  end
end
