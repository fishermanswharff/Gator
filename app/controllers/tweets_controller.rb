class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @twitter_client = TwitterClient
    auths = UserAuthentication.all.select { |auth| auth.user_id == current_user.id }
    has_twitter = auths.select { |auth| auth.params.provider == "twitter" }
    if has_twitter.length > 0
      @identity = auths.map { |auth| auth if auth.params.provider == "twitter" }.compact[0]
      @twitter_client.access_token = @identity.params.credentials.token
      @twitter_client.access_token_secret = @identity.params.credentials.secret
    end
    
    begin
      @user = @twitter_client.user
      @tweets = @twitter_client.home_timeline
      # binding.pry
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      # retry
    end
  end

  def collect_with_max_id(collection=[], max_id=nil,&block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def get_all_tweets(user)
    collect_with_max_id do |max_id|
      options = {:count => 200, :include_rts => true}
      options[:max_id] = max_id unless max_id.nil?
      @timeline = @twitter_client.home_timeline
      # user_timeline(user, options)
    end
  end

  def update(text)
    @twitter_client.update(text)
  end
end