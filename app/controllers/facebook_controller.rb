class FacebookController < ApplicationController
  def index
    auths = UserAuthentication.all.select { |auth| auth.user_id == current_user.id }
    has_facebook = auths.select { |auth| auth.params.provider == "facebook" }
    if has_facebook
      @identity = auths.map { |auth| auth if auth.params.provider == "facebook" }.compact[0]
      @fb_client = Facebook.new(@identity.params.credentials.token)
    else
      "You haven't connected to Twitter through Gator."
    end
  end
end

=begin
#sql query that gives back the tokens on the provider's id
SELECT user_authentications.token
FROM user_authentications
LEFT JOIN authentication_providers
ON (user_authentications.id = authentication_providers.id);
=end