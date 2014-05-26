class Contract < ActiveRecord::Base
  include Filterable
  include I18n::Alchemy
  
  belongs_to :insurant
  belongs_to :insured
  belongs_to :user, foreign_key: 'agent_id'
  
  validates :number, presence:true, uniqueness: true
  validates :insurant_id, presence:true
  validates :insured_id, presence: true
  
  scope :fnumber, ->(f) {where("number like ?","%#{f}%")}
  scope :fdate_f, ->(d) {where("date >= ?", d)}
  scope :fdate_l, ->(d) {where("date <= ?", d)}
  scope :fdatestart_f, ->(d) {where("datestart >= ?", d)}
  scope :fdatestart_l, ->(d) {where("datestart <= ?", d)}
  scope :fdatefinish_f, ->(d) {where("datefinish >= ?", d)}
  scope :fdatefinish_l, ->(d) {where("datefinish <= ?", d)}
  scope :fcost, ->(c) {where("cost = ?",c)}
  scope :fikp, ->(i) {where("users.ikp = ?",i)}
  scope :finsurant_name, ->(f) {where("people.firstname like :n or people.lastname like :n",n: "%#{f}%")}
  scope :finsured_name, ->(f) {where("insureds_contracts.firstname like :n or insureds_contracts.lastname like :n",n: "%#{f}%")}

end
