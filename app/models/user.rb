require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_secure_password
  has_many :plants
  has_many :plant_statuses, through: :plants
  has_many :plant_instructions, through: :plants
end
