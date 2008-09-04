class User < ActiveRecord::Base
  include HasMedia
  
  has_many :relationships
  has_many :groups, :through => :relationships
  
  named_scope :active_users, lambda{|opts| 
    {:conditions => ["users.active = ?", true], :limit => 5}.merge(opts)
  }
end