class Instruction < ActiveRecord::Base
  belongs_to :plant
  # validates_presence_of :water_amt, :water_amt_unit, :water_freq, :water_freq_unit
end
