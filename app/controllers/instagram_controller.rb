class InstagramController < ApplicationController
  before_action :authenticate_user!
  def index
    auths = UserAuthentication.all.select { |auth| auth.user_id == current_user.id }
    has_instagram = auths.select { |auth| auth.params.provider == "instagram" }
    if has_instagram.length > 0
      @identity = auths.map { |auth| auth if auth.params.provider == "instagram" }.compact[0]
      @client = Instagram.client(@identity.params.credentials)
      @client.access_token = @identity.token
      @page_1 = @client.user_media_feed(777)
        

      binding.pry
      # this page 2 script was returning some weird biker dude's instagram feed
      # page_2_max_id = @page_1.pagination.next_max_id
      # @page_2 = @client.user_recent_media(777, max_id: page_2_max_id) unless page_2_max_id.nil?
      
      @response = @client.utils_raw_response
    end
  end
end