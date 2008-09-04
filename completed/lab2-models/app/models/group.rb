class Group < ActiveRecord::Base
  include HasMedia
  has_many :relationships
  has_many :users, :through => :relationships
  
  named_scope :top, lambda {|count|
    {:conditions => ["groups.rank < 10"], :limit => count}
  }
end