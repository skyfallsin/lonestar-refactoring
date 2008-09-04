class Videoclip < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  def owned_by?(owner)
    if owner.kind_of?(User)
      user && user == owner
    elsif owner.kind_of?(Group)
      group && group == owner
    else
      false
    end
  end
end