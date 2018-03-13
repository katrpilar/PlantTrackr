class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :picture
      t.integer :owner_id
    end
  end
end
