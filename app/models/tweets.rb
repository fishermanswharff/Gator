class Tweets

  def initialize(current_user)
    twitter_client = TwitterClient
    auths = UserAuthentication.all.select { |auth| auth.user_id == current_user.id }
    has_twitter = auths.select { |auth| auth.params.provider == "twitter" }
    if has_twitter.length > 0
      identity = auths.map { |auth| auth if auth.params.provider == "twitter" }.compact[0]
      twitter_client.access_token = identity.params.credentials.token
      twitter_client.access_token_secret = identity.params.credentials.secret
    end
    @client = twitter_client
  end

  def get_user
    @user = @client.user
  end

  def get_timeline
    @tweets = @client.home_timeline
  end
end