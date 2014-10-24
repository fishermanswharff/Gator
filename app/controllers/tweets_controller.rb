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

    @user = @twitter_client.user
    @tweets = @twitter_client.home_timeline

    begin
      # binding.pry
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      flash[:notice] = "Too Many Requests!!"
      # retry
    end
  end

  def collect_with_max_id(collection=[], max_id=nil,&block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def update(text)
    @twitter_client.update(text)
  end
end