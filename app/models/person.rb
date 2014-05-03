class Person < ActiveRecord::Base
  has_many :contracts, foreign_key: "strahovatel_id"
  has_many :users, through: :contracts, foreign_key: "agent_id"
  belongs_to :organization
  validates :firstname, :lastname, presence:true
  valid_passport_regex=/[\-IRO0-9]{4} +[0-9]{6}/
  validates :passport, presence: true,
    format: {with: valid_passport_regex}
  
  accepts_nested_attributes_for :organization
  
end
