module RSSGetter

  require 'net/http'
  require 'uri'
  require 'pry'
  require 'nokogiri'
  require 'open-uri'

  class NPR
    
    NPR_URL = "http://www.npr.org"

    def initialize(url)
      page = Nokogiri::HTML(open(url))
      rss_links = page.css("a").select{ |link| link['class'] == "iconlink xml"}
      titles = get_titles(rss_links)
      urls = get_urls(rss_links)
      Hash[titles.zip(urls.map{|i| i.split /,/})]
    end

    def get_titles(array) 
      titles = array.map { |link| link.children.to_s } 
    end

    def get_urls(array)
      urls = array.map { |link| link['href'] }
      urls = urls.each { |url| url.prepend(NPR_URL) }
    end

  end

end

RSSGetter::NPR.new("http://www.npr.org/rss/")