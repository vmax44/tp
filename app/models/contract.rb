class Contract < ActiveRecord::Base
  belongs_to :strahovatel, class_name: 'Person'
  belongs_to :zastrahovanniy, class_name: 'Person'
  belongs_to :user, foreign_key: 'agent_id'
  validates :number, presence:true, uniqueness: true
  
end
