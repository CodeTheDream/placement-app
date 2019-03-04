class AddNametoPlacements < ActiveRecord::Migration[5.2]
  def change
    add_column :placements, :name, :string
  end
end
