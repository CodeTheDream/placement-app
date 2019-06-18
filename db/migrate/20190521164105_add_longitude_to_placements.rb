class AddLongitudeToPlacements < ActiveRecord::Migration[5.2]
  def change
    add_column :placements, :longitude, :float
  end
end
