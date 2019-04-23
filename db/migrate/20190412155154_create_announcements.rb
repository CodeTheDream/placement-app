class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.integer :user_id
      t.string :text
      t.integer :placement_id
      t.integer :licensee_id
      t.boolean :bed_available, default: false
      t.timestamps
    end
  end
end

