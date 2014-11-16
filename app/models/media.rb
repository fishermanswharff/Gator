class Media
  require "#{Rails.root}/app/modules/MediaGetter.rb"
  def initialize(url, options={})
    if options.values[0] == "image"
      @media = MediaGetter::Image.new(url)
      binding.pry
    end
  end
end