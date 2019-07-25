class CreateCounties < ActiveRecord::Migration[5.2]
  def change
    create_table :counties do |t|
      t.string :name
      t.string :string
      t.string :mco
      t.string :statehospital

      t.timestamps
    end
  end
end
