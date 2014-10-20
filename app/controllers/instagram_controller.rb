class InstagramController < ApplicationController
  before_action :authenticate_user!
  def index
    auths = UserAuthentication.all.select { |auth| auth.user_id == current_user.id }
    has_instagram = auths.select { |auth| auth.params.provider == "instagram" }
    if has_instagram.length > 0
      @identity = auths.map { |auth| auth if auth.params.provider == "instagram" }.compact[0]
      @client = Instagram.client(@identity.params.credentials)
      @client.access_token = @identity.token
      @client
    else
      "You haven't connected to Twitter through Gator."
    end
  end
end