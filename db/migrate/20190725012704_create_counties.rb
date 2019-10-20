class CreateCounties < ActiveRecord::Migration[5.2]
  def change
    create_table :counties do |t|
      t.string :name
      t.string :mco
      t.string :hospital
      t.timestamps
    end
  end
end
