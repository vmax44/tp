class Person < ActiveRecord::Base
  has_many :users, through: :contracts, foreign_key: "agent_id"
  
  validates :firstname, :lastname, presence:true
  valid_passport_regex=/[\-IRO0-9]{4} +[0-9]{6}/
  validates :passport, presence: true,
    format: {with: valid_passport_regex}
  
  def name
    "#{lastname} #{firstname}"
  end
  
  def self.where_name_like(f)
    where("firstname like ? or lastname like ?",f,f)
  end
  
end
