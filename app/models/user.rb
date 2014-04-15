class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
       
  has_many :contracts, foreign_key: "agent_id"
  has_many :strahovatels, :through => :contracts
  has_many :zastrahovanniys, :through => :contracts
  has_many :organizations, -> {uniq}, :through => :strahovatels
  has_many :organizations_zastr, -> {uniq}, :through => :zastrahovanniys, :source => :organization

end
