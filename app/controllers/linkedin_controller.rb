class LinkedinController < ApplicationController
  before_action :authenticate_user!
  def index
    @client = LinkedinClient
    auths = UserAuthentication.all.select { |auth| auth.user_id == current_user.id }
    has_linkedin = auths.select { |auth| auth.params.provider == "linkedin" }
    if has_linkedin.length > 0
      @identity = auths.map { |auth| auth if auth.params.provider == "linkedin" }.compact[0]
      @client.access_token.params = @identity.params.extra.access_token.params
      @client.access_token.secret = @identity.params.extra.access_token.secret
      @client.access_token.token = @identity.params.extra.access_token.token
      @connections = @client.network_updates(type: 'CONN')
      @shares = @client.network_updates(type: 'SHAR')
    end
  end
end