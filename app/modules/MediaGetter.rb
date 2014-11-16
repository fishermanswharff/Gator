module MediaGetter

  # this is a sweet fucking gem
  require 'nokogiri'
  require 'open-uri'
  require 'byebug'

  class Image

    def initialize(url)
      page = Nokogiri::HTML(open(url))
      images = page.css('img')
      
      begin
        # gets the src of the image with the longest alt text on the page, but not all alt attributes have values, hence rescuing this block of code
        alts = images.map {|image| image.attributes["alt"]  }.compact
        longest = alts.map { |alt| alt.children.to_s }.group_by(&:length).max
        the_alt = longest[1][0]
        the_image = images.map { |img| img if img.attributes["alt"].to_s == the_alt }.compact
        return @src = the_image[0].attributes["src"].to_s
      rescue NoMethodError => e
        puts e.message
      end
      
    end
  end
end

# MediaGetter::Image.new("http://www.reuters.com/article/2014/10/25/us-canada-attacks-shooting-idUSKCN0IB1PY20141025?feedType=RSS&feedName=worldNews")