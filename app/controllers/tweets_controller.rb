class TweetsController < ApplicationController

  # before_action :authenticate_user!

  def index
    @current_user = User.find(current_user)
    current_id = @current_user.id
    auth = UserAuthentication.find_by_user_id(current_id)
    @identity = UserAuthentication.find(auth)
    @client = TwitterClient
    @client.access_token = @identity.params.credentials.token
    @client.access_token_secret = @identity.params.credentials.secret
    @timeline = @client.home_timeline
  end

  def update(text)
    @client.update(text)
  end

end