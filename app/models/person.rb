class Person < ActiveRecord::Base
  has_many :contracts, foreign_key: "strahovatel_id"
  has_many :users, through: :contracts, foreign_key: "agent_id"
  belongs_to :organization
  validates :firstname, :lastname, presence:true
  accepts_nested_attributes_for :organization
  
end
