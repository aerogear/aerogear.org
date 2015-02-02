require 'rss'
require 'curb'
require 'diskcached'

module Reading
  class Generator < Jekyll::Generator
    def generate(site)
      # urls = %w[http://dcp.jboss.org/v1/rest/feed/?sys_type=blogpost&tag=aerogear]
      # feeds = Feedjira::Feed.fetch_and_parse urls
      # feed = feeds['http://dcp.jboss.org/v1/rest/feed/?sys_type=blogpost&tag=aerogear']
      # puts feed.title
      # site.data['yummy'] = feeds

      diskcache = Diskcached.new('/tmp/aerogear.site.cache', 10)

      feed_xml = diskcache.cache('feed_planet_aerogear_tag') do
        url = 'http://dcp.jboss.org/v1/rest/feed/?sys_type=blogpost&tag=feed_name_mwessendorf&tag=feed_name_krisborchers'
        http = Curl.get(url)
        http.body_str
      end

      feed_to_hash = []
      feed = RSS::Parser.parse(feed_xml)
      feed.items.each do |item|
        tags = []
        item.categories.each do |cat|
          tag = cat.term
            tags.push(tag) unless tag =~ /^feed_/ || ["aerogear", "mobile", "Uncategorized"].include?(tag)
        end
        feed_to_hash.push({
                              "title" => item.title.content,
                              "url" => item.link.href,
                              "date" => item.published.content,
                              "excerpt" => item.summary.content,
                              "author" => item.author.name.content,
                              "tags" => tags
                          })
      end

      site.data['feed'] = feed_to_hash
    end
  end
end