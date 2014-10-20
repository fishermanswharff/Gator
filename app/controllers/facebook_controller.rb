class FacebookController < ApplicationController
  
  def index
    @current_user = User.find(current_user)
    current_id = @current_user.id
    auth = UserAuthentication.find_by_user_id(current_id)
    if auth.params.provider == "facebook"
      @identity = UserAuthentication.find(auth)
      @fb_client = Facebook.new(@identity.params.credentials.token)
    else
      @fb_client = nil
    end
    # auth.params.provider == "facebook"
    # @provider = AuthenticationProvider.find_by_name('facebook') 
    # @auth = UserAuthentication.find_by_authentication_provider_id(@provider.id)
    # @auth.token
    # @client = Facebook.new(@auth.token)
    # @client
    binding.pry
  end
end

=begin
#sql query that gives back the tokens on the provider's id
SELECT user_authentications.token
FROM user_authentications
LEFT JOIN authentication_providers
ON (user_authentications.id = authentication_providers.id);
=end