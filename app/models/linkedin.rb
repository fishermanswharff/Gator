class Linkedin
  
  def initialize(current_user)
    client = LinkedinClient
    auths = UserAuthentication.all.select { |auth| auth.user_id == current_user.id }
    has_linkedin = auths.select { |auth| auth.params.provider == "linkedin" }
    if has_linkedin.length > 0
      identity = auths.map { |auth| auth if auth.params.provider == "linkedin" }.compact[0]
      client.access_token.params = identity.params.extra.access_token.params
      client.access_token.secret = identity.params.extra.access_token.secret
      client.access_token.token = identity.params.extra.access_token.token
    end
    @client = client
  end

  def get_connections
    @client.network_updates(type: "CONN").all
  end

  def get_shares
    @client.network_updates(type: "SHAR").all
  end

  def get_profile
    @client.profile
  end
end