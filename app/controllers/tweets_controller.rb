class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @client = Tweets.new(current_user)
    @user = @client.get_user
    @tweets = @client.get_timeline
  end

  def update(text)
    @twitter_client.update(text)
  end
end