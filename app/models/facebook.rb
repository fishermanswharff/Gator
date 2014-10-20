require 'net/http'
class Facebook 
  include HTTParty

  format :json
  base_uri 'https://graph.facebook.com/v2.1/'

  def initialize(access_token)
    @access_token = access_token
  end  

  def get_info
    self.class.get('/me',:query => { :access_token => @access_token })    
  end

  def get_timeline
    self.class.get('/me/feed', :query => { :access_token => @access_token } )
  end

  def get_name 
    self.class.get('/me?fields=name', :query => { :access_token => @access_token } )
  end
end