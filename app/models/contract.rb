class Contract < ActiveRecord::Base
  belongs_to :insurant
  belongs_to :insured
  belongs_to :user, foreign_key: 'agent_id'
  validates :number, presence:true, uniqueness: true
  validates :strahovatel_id, presence:true
  validates :zastrahovanniy_id, presence: true
  #default_scope -> { order("strahovatel.firstname asc")}
  
end
