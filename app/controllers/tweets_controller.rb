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
      @timeline = @twitter_client.home_timeline
    else
      "You haven't connected to Twitter through Gator."
    end
  end
  def update(text)
    @twitter_client.update(text)
  end
end