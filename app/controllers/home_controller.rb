class HomeController < ApplicationController
  def index
    if User.all.length == 0
      redirect_to new_user_registration_path
    end
    if user_signed_in?
      @user = User.find(current_user)
      @user_feeds = Feed.get_user_feeds(current_user)
      @users = find_users(@user_feeds)
    else
      @users = User.includes(:feeds)
    end
  end

  private
  def find_users(array)
    array.map do |item|
      User.find(item.user_id).email
    end
  end
end