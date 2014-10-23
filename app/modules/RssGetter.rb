module RssGetter

  require 'nokogiri'
  require 'open-uri'

  class NPR
    
    NPR_URL = "http://www.npr.org"

    def initialize(url)
      @page = Nokogiri::HTML(open(url))
      parse
    end

    def parse
      @rss_links = @page.css("a").select{ |link| link['class'] == "iconlink xml"}
      @titles = get_titles(@rss_links)
      @urls = get_urls(@rss_links)
    end

    def get_titles(array) 
      array.map { |link| link.children.to_s } 
    end

    def get_urls(array)
      array.map! { |link| link['href'] }
      array.map! { |url| url.prepend(NPR_URL) }
    end

    def to_hash
      Hash[@titles.zip(@urls.map{|i| i.split /,/})]
    end
  end

  class NYT

    def initialize(url)
      @page = Nokogiri::HTML(open(url))
      parse
    end

    def parse
      @rss_links = @page.css("ul.rssColumns a").select { |link| link }
      @titles = @rss_links.map { |link| link.children.to_s }
      @urls = @rss_links.map { |link| link['href'] }
    end

    def to_hash
      Hash[@titles.zip(@urls.map{|i| i.split /,/})]
    end
  end

  class TMZ
    def initialize(url)
      @page = Nokogiri::HTML(open(url))
      parse
    end

    def parse
      @rss_links = @page.css("div#main-content li a").select { |link| link }
      @titles = @rss_links.map { |link| link.children.to_s }
      @urls = @rss_links.map { |link| link['href'] } 
    end

    def to_hash
      Hash[@titles.zip(@urls.map{|i| i.split /,/})]
    end
  end

  class Links
    def initialize(url, params)
      @page = Nokogiri::HTML(open(url))
      parse(params)
    end

    def parse(params)
      @rss_links = @page.css("#{params}").select { |link| link }
      @titles = @rss_links.map { |link| link.children.to_s }
      @urls = @rss_links.map { |link| link['href'] } 
    end

    def to_hash
      Hash[@titles.zip(@urls.map{|i| i.split /,/})]
    end 
  end
end

# RSSGetter::NPR.new("http://www.npr.org/rss/")