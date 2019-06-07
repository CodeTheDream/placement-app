class AddFullAddressToPlacement < ActiveRecord::Migration[5.2]
  def change
    add_column :placements, :full_address, :string
  end
end
