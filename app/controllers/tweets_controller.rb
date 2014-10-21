class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    auths = UserAuthentication.all.select { |auth| auth.user_id == current_user.id }
    has_twitter = auths.select { |auth| auth.params.provider == "twitter" }
    if has_twitter.length > 0
      @identity = auths.map { |auth| auth if auth.params.provider == "twitter" }.compact[0]
      @twitter_client = TwitterClient
      @twitter_client.access_token = @identity.params.credentials.token
      @twitter_client.access_token_secret = @identity.params.credentials.secret
      # @timeline = @twitter_client.home_timeline
    end
    user = @twitter_client.user
    get_all_tweets(user)
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
      # user.home_timeline(user, options)
    end
    binding.pry
  end

  def update(text)
    @twitter_client.update(text)
  end
end