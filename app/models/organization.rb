class Organization < ActiveRecord::Base
  #has_many :strahovatels, class_name: 'Person'
  #has_many :zastrahovanniys, class_name: 'Person'
  has_many :people
  has_many :contracts, :through => :people
  has_many :users, -> {uniq}, through: :contracts
end
