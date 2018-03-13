class CreateInstructions < ActiveRecord::Migration[5.1]
  def change
    create_table :instructions do |t|
      t.integer :water_amt
      t.string :water_amt_unit
      t.string :water_freq
      t.string :water_freq_unit
      t.integer :plant_id
    end
  end
end
