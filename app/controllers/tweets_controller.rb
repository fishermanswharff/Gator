class TweetsController < ApplicationController

  before_action :authenticate_user!

  def index
    @client = TwitterClient
    @timeline = @client.home_timeline
    binding.pry
  end

  # def prepare_access_token(oauth_token, oauth_token_secret)
  #   consumer = OAuth::Consumer.new(ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"], { :site => "https://api.twitter.com", :scheme => :header })
  #   # now create the access token object from passed values
  #   token_hash = { :oauth_token => ENV["TWITTER_ACCESS_TOKEN"], :oauth_token_secret => ENV["TWITTER_ACCESS_SECRET"] }
  #   access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
  #   return access_token
  # end
  
  # # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
  # access_token = prepare_access_token(ENV["TWITTER_ACCESS_TOKEN"], ENV["TWITTER_ACCESS_SECRET"])
  # # use the access token as an agent to get the home timeline
  # response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")

  # @client.screen_name

end