class Menu
  require "#{Rails.root}/app/modules/RssGetter.rb"
  def initialize(url, options={})
    if options.values[0] == "NPR"
      @hash = RssGetter::NPR.new(url).to_hash
    elsif options.values[0] == "NYT"
      @hash = RssGetter::NYT.new(url).to_hash
    elsif options.values[0] == "TMZ"
      @hash = RssGetter::TMZ.new(url).to_hash
    elsif options.values[0] == "MISC"
      @hash = RssGetter::Links.new(url, options.values[1]).to_hash
    end
  end
end