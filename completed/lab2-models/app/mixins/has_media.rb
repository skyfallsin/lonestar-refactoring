module HasMedia
  def self.included(base)
    base.class_eval do
      has_many :audioclips, :extend => AudioclipFinderExtensions
      has_many :videoclips, :extend => VideoclipFinderExtensions
    end
  end
  
  module AudioclipFinderExtensions
    def new_audioclips(since=3.weeks.ago)
      find(:all, :conditions => ["created_at > ?", since])
    end
  end
  
  module VideoclipFinderExtensions
    def encoded_videoclips(opts={})
      find(:all, {:conditions => ["encoded = ?", true]}.merge(opts))
    end
  end
end