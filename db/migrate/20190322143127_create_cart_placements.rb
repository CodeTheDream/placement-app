class CreateCartPlacements < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_placements do |t|
      t.references :cart, foreign_key: true
      t.references :placement, foreign_key: true
      t.timestamps
    end
  end
end
