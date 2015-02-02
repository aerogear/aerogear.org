require 'rss'
require 'curb'
require 'diskcached'

module Reading
  class Generator < Jekyll::Generator

    def lookup_author(site, identifier)
      author = site.data["team"][identifier]
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

    def generate(site)
      diskcache = Diskcached.new('/tmp/aerogear.site.cache', 10)

      feed_xml = diskcache.cache('feed_planet_aerogear_tag') do
        url = 'http://dcp.jboss.org/v1/rest/feed/?sys_type=blogpost&tag=feed_name_mwessendorf&tag=feed_name_krisborchers'
        http = Curl.get(url)
        http.body_str
      end



      posts = []
      feed = RSS::Parser.parse(feed_xml)
      feed.items.each do |item|
        tags = []
        item.categories.each do |cat|
          tag = cat.term
            tags.push(tag) unless tag =~ /^feed_/ || ["aerogear", "mobile", "Uncategorized"].include?(tag)
        end
        posts << {
          "date" => "#{item.published.content}",
          "title" => item.title.content,
          "url" => item.link.href,
          "excerpt" => item.summary.content,
          "author" => lookup_author(site, item.author.name.content),
          "tags" => tags
        }
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