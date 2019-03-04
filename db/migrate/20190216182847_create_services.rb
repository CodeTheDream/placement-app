class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.string :prog_code
      t.string :age_code
      t.timestamps
    end
  end
end
