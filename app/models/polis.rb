class Polis < ActiveRecord::Base
  belongs_to :strahovatels
  belongs_to :users
  
end
