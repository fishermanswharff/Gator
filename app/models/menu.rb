class Menu 

  require "#{Rails.root}/app/modules/RssGetter.rb"

  def initialize(url)
    @hash = RssGetter::NPR.new(url).to_hash
  end

end