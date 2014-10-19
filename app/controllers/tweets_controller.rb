class TweetsController < ApplicationController

  before_action :authenticate_user!

  def index
    @client = TwitterClient
    @timeline = @client.home_timeline
    binding.pry
  end

  def update(text)
    @client.update(text)
  end

end