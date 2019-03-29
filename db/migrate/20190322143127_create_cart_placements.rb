class CreateCartPlacements < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_placements do |t|
      t.integer :cart_id
      t.integer :placement_id
      t.timestamps
    end
  end
end
