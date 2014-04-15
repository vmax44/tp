class Contract < ActiveRecord::Base
  belongs_to :strahovatel, class_name: 'Person'
  belongs_to :zastrahovanniy, class_name: 'Person'
  has_one :organization_s, through: :strahovatel, source: 'organization'
  has_one :organization_z, through: :zastrahovanniy, source: 'organization'
  belongs_to :user, foreign_key: 'agent_id'
  validates :number, presence:true, uniqueness: true
  
  accepts_nested_attributes_for :strahovatel
  accepts_nested_attributes_for :zastrahovanniy
  accepts_nested_attributes_for :organization_s
  accepts_nested_attributes_for :organization_z
end
