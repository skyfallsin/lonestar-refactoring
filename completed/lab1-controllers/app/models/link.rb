class Link < ActiveRecord::Base
  has_many :tags
  
  before_create :set_default_name
  before_create :set_canonical_url
  
  named_scope :created_since_three_weeks_ago, 
      :conditions => ["created_at > ?", 3.weeks.ago], 
      :order => "created_at DESC")
  
  private
  def set_default_name
    self.name = name || "Unknown Link"
  end
  
  def set_canonical_url
    self.curl = url.gsub("http://", "").gsub("https://", "").gsub("www.", "")
  end
end