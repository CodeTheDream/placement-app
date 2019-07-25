class ChangeCountyToCountyId < ActiveRecord::Migration[5.2]
  def change
    remove_column :placements, :county
    add_column :placements, :county_id, :integer
  end
end
