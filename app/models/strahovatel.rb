class Strahovatel < ActiveRecord::Base
  has_many :polis
  has_many :users
  belongs_to :organizations
  
end
