class FeedsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:title, :url, :description)
  end

end