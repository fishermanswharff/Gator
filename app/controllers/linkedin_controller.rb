class LinkedinController < ApplicationController
  before_action :authenticate_user!
  def index
    # binding.pry
    @client = Linkedin.new(current_user)
    @profile = @client.get_profile
    @connections = @client.get_connections
    @shares = @client.get_shares
  end
end