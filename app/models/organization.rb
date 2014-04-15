class Organization < ActiveRecord::Base
  has_many :people
  has_many :contracts, :through => :people
  has_many :users, -> {uniq}, through: :contracts
end
