class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.string :update
      t.date :status_date
      t.integer :plant_id
    end
  end
end
