class Group < ActiveRecord::Base
  
  has_many :audioclips
  has_many :videoclips
  
  has_many :relationships
  has_many :users, :through => :relationships
  
  def new_audioclips(since=3.weeks.ago)
    audioclips.select{|x| x.created_at > since}
  end
  
  def encoded_videoclips
    videoclips.select{|x| x.encoded? }
  end
  
  def self.top_groups(count=5)
    find(:all, :conditions => ["groups.rank < 10"], :limit => count)
  end
  
end