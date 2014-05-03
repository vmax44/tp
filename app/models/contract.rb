class Contract < ActiveRecord::Base
  belongs_to :strahovatel, class_name: 'Person'
  belongs_to :zastrahovanniy, class_name: 'Person'
  has_one :organization, through: :strahovatel
  belongs_to :user, foreign_key: 'agent_id'
  validates :number, presence:true, uniqueness: true
  validates :strahovatel_id, presence:true
  validates :zastrahovanniy_id, presence: true
  
  accepts_nested_attributes_for :strahovatel
  accepts_nested_attributes_for :zastrahovanniy
  accepts_nested_attributes_for :organization
end
