module IsOwned
  def self.included(base)
    base.class_eval do
      belongs_to :user
      belongs_to :group
    end
    base.send(:include, OwnerMatchers)
  end
  
  module OwnerMatchers
    def owned_by?(owner)
      return user == owner if owner.kind_of?(User) && user
      return group == owner if owner.kind_of?(Group) && group
      false
    end 
  end
end