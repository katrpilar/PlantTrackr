class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.string :event
      t.date :event_date
      t.string :soil_status
      t.string :leaf_status
      t.integer :plant_id
    end
  end
end
