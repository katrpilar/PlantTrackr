class Plant < ActiveRecord::Base
  belongs_to :user
  has_many :instructions
  has_many :statuses
end
