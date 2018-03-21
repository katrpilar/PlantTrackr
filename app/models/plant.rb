class Plant < ActiveRecord::Base
  belongs_to :user
  has_many :instructions
  has_many :statuses
  validates_presence_of :name, message: 'Your plant must have a name'
  validates_presence_of :picture, :sunlight, :soil, :container_size, :drainage
end
