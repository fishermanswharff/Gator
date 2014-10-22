class FeedsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feed
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    @feed.title = Feed.set_title(@feed)
    if @feed.save
      redirect_to @feed
    else
      render 'new'
    end
  end

  def show
    @user = User.find(@feed.user_id)
    @parsed = Feed.init(@feed.url)

    binding.pry
  end

  def edit
  end

  def update
  end

  def destroy
    @feed.destroy
    redirect_to root_path
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:title, :url, :description)
  end

end