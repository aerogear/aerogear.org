require 'rss'
require 'curb'
require 'diskcached'

module Reading
  class Generator < Jekyll::Generator

    def lookup_author(site, identifier)
      author = site.data["people"][identifier]
      if author == nil then
        site.data["people"].each do |nick, person|
          if identifier.eql? person["name"] then
            author = person
          end
        end
      end
      if author then
        return {
            "name" =>author["name"],
            "avatar" => author["avatar"]
        }
      else
        return {
            "name" => identifier
        }
      end
    end

    def include_blog_entry_in_news_feed(entry, categories)
      return categories.include? "aerogear" || entry.title.content =~ /aerogear/i || entry.summary.content =~ /aerogear/i;
    end

    def generate(site)
      diskcache = Diskcached.new('/tmp/aerogear.site.cache', 10)
      feed_names = []
      site.data["people"].each do |nick, person|
          feed_names << person["jboss-planet-tag"] if person["jboss-planet-tag"]
      end
      feed_names =
      feed_xml = diskcache.cache('feed_planet_aerogear_tag') do
        url = 'http://dcp.jboss.org/v1/rest/feed/?sys_type=blogpost&tag=' + feed_names.join("&tag=")
        http = Curl.get(url)
        http.body_str
      end



      posts = []
      feed = RSS::Parser.parse(feed_xml)
      feed.items.each do |entry|
        categories = []
        entry.categories.each do |cat|
          categories << cat.term
        end
        if include_blog_entry_in_news_feed(entry, categories) then
          tags = []
          categories.each do |category|
            tags << category unless category =~ /^feed_/ || ["aerogear", "mobile", "Uncategorized"].include?(category)
          end
          posts << {
            "date" => "#{entry.published.content}",
            "title" => entry.title.content,
            "url" => entry.link.href,
            "excerpt" => entry.summary.content,
            "author" => lookup_author(site, entry.author.name.content),
            "tags" => tags
          }
        end
      end

      site.posts.each do |post|
        posts << {
          "date" => "#{post.date}",
          "url" => post.url,
          "title" => post.title,
          "excerpt" => post.excerpt,
          "author" => lookup_author(site, post.data["author"]),
          "tags" => post.tags
        } if post.published?
      end

      posts.sort! { |a,b| b["date"].casecmp(a["date"]) }

      site.data['all_posts'] = posts
    end
  end
end