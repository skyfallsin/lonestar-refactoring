class User < ActiveRecord::Base
  has_many :audioclips
  has_many :videoclips
  
  has_many :relationships
  has_many :groups, :through => :relationships
  
  # this method returns the top groups the user is in
  def top_groups
    groups.select{|x| x.rank < 10}
  end
  
  def new_audioclips(since=3.weeks.ago)
    audioclips.select{|x| x.created_at > since}
  end
  
  def encoded_videoclips
    videoclips.select{|x| x.encoded? }
  end
  
  def self.active_users
    self.find(:all, :conditions => ["groups.active = ?", true])
  end
end