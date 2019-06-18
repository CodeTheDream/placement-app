class AddLatitudeToPlacements < ActiveRecord::Migration[5.2]
  def change
    add_column :placements, :latitude, :float
  end
end
