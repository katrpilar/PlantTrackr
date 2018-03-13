class CreatePlants < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :picture
      t.string :sunlight
      t.string :soil
      t.string :container_size
      t.string :drainage
      t.integer :user_id
    end
  end
end
