class Plant < ActiveRecord::Base
  belongs_to :user
  has_many :instructions
  has_many :statuses
  validates_presence_of :name, :picture, :sunlight, :soil, :container_size, :drainage, :water_amt, :water_amt_unit, :water_freq, :water_freq_unit
end
