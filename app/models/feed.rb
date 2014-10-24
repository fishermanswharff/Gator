class Feed < ActiveRecord::Base
  belongs_to :user
  validates_with GoodnessValidator, fields: [:url]
  validates :url, uniqueness: true
  
  def self.init(url)
    @feed = Feedjira::Feed.fetch_and_parse(url)
  end

  def self.set_title(feed)
    parsed = Feedjira::Feed.fetch_and_parse(feed.url)
    parsed.title ? feed.title = parsed.title : ""
  end

  def self.get_unique_feeds
    all = Feed.all
    urls = all.map { |feed| feed.url } 
    urls.uniq!
    urls.map do |u| 
      get_feed_object(u)
    end
  end

  def self.get_user_feeds(current_user)
    Feed.all.map { |feed| feed if feed.user_id == current_user.id }.compact
  end

  def self.get_feed_object(url)
    Feed.all.each do |feed|
      return feed if feed.url == url
    end
  end
  
end






































  
  # validates_with GoodnessValidator, fields: [:url]
  # validate do |feed|
  #   GoodnessValidator.new(feed).validate
  # end



# class GoodnessValidator
#   def initialize(feed)
#     @feed = feed
#   end

#   def validate
#     
#     failure_callback = lambda { |curl, err| puts curl, err }
#     @feed = Feedjira::Feed.fetch_and_parse @feed, on_failure: failure_callback
#     if @feed == nil
#       @feed.errors[:base] << failure_callback
#     end
#   end
# end