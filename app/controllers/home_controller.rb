class HomeController < ApplicationController
  def index
    if User.all.length == 0
      redirect_to new_user_registration_path
    end

    if user_signed_in?
      @user = User.find(current_user)
      @user_feeds = Feed.get_user_feeds(current_user)
    else
      @feeds = Feed.get_unique_feeds
      binding.pry
    end
  end
end