class FacebookController < ApplicationController
  def index
    @provider = AuthenticationProvider.find_by_name('facebook') 
    @auth = UserAuthentication.find_by_authentication_provider_id(@provider.id)
    @auth.token
    @client = Facebook.new(@auth.token)
    @client
  end
end
=begin
#sql query that gives back the tokens on the provider's id
SELECT user_authentications.token
FROM user_authentications
LEFT JOIN authentication_providers
ON (user_authentications.id = authentication_providers.id);
=end