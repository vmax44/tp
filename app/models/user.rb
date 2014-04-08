class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
       
  has_many :polis
  has_many :strahovatels, :through => :polis
  has_many :organizations, :through => :strahovatels
  
end
