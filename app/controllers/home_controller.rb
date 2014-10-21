class HomeController < ApplicationController
  def index
    if User.all.length == 0
      redirect_to new_user_registration_path
    end
    
    if user_signed_in?
      # @user_feeds = @user.feeds.all
    else
      @feeds = []
      @feeds << Feedjira::Feed.fetch_and_parse('http://rss.cnn.com/rss/cnn_topstories.rss')
      @feeds << Feedjira::Feed.fetch_and_parse('http://www.npr.org/rss/rss.php?id=1001')
      @feeds << Feedjira::Feed.fetch_and_parse('http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml')
      @feeds
      binding.pry
    end
  end
end