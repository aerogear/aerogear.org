require 'rss'
require 'curb'
require 'diskcached'

module Reading
  class Generator < Jekyll::Generator

    def generate(site)
      diskcache = Diskcached.new('/tmp/aerogear.site.cache', 300)
      feed_names = []
      site.data["people"].each do |nick, person|
          feed_names << person["jboss-planet-tag"] if person["jboss-planet-tag"]
      end
      feed_xml = diskcache.cache('feed_planet_aerogear_tag') do
        url = 'http://dcp.jboss.org/v1/rest/feed/?sys_type=blogpost&tag=' + feed_names.join("&tag=")
        Jekyll.logger.info "rss_atom_posts:", "fetching #{url}"
        http = Curl.get(url) do|http|
          http.follow_location = true
        end
        http.body_str
      end

      all_data = Set.new

      posts = []
      feed = RSS::Parser.parse(feed_xml)
      feed.items.each do |entry|
        categories = []
        entry.categories.each do |cat|
          categories << cat.term
        end
        if include_blog_entry_in_news_feed(entry, categories) then
          data_set = get_data_as_set(site, categories)
          is_release = data_set.include?('release')
          author = lookup_author(site, entry.author.name.content)
          mod = lookup_module(site, nil, data_set)
          platform = lookup_platform(site, nil, data_set)
          data = data_set.to_a
          classes = derive_classes(data, mod, platform, is_release)

          all_data.merge(data)

          post = {
            "date" => "#{entry.published.content}",
            "title" => entry.title.content,
            "url" => entry.link.href,
            "excerpt" => entry.summary.content,
            "author" => author,
            "module" => mod,
            "platform" => platform,
            "data" => data,
            "classes" => classes,
            "external" => true
          }
          posts << post
        end
      end

      site.posts.each do |post|
        mod = lookup_module(site, post.data["module"], Set.new)
        platform = lookup_platform(site, post.data["platform"], Set.new)
        is_release = post.data["releases"] != nil
        classes = derive_classes(post.data, mod, platform, is_release)

        all_data.merge(post.data)

        if post.published? then
          posts << {
            "date" => "#{post.date}",
            "url" => post.url,
            "title" => post.data["title"],
            "excerpt" => post.data["excerpt"],
            "author" => lookup_author(site, post.data["author"]),
            "data" => post.data,
            "module" => mod,
            "platform" => platform,
            "releases" => post.data["releases"],
            "classes" => classes,
            "external" => false
          }
        end
      end

      posts.sort! { |a,b| b["date"].casecmp(a["date"]) }

      site.data['all_posts'] = posts
      site.data['all_post_data'] = all_data.to_a
    end

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

    def lookup_module(site, modName, data)
      mappings = site.data["post-tag-mapping"]
      if modName then
        return site.data["modules"][modName]
      end
      data.each do |tag|
        if mappings[tag] == '=module' then
          data.delete(tag)
          return site.data["modules"][tag] if site.data["modules"][tag]
        end
      end
      return nil
    end

    def lookup_platform(site, platformName, data)
      mappings = site.data["post-tag-mapping"]
      if platformName then
        return site.data["sdk"][platformName]
      end
      data.each do |tag|
        if mappings[tag] == '=platform' then
          data.delete(tag)
          return site.data["sdk"][tag] if site.data["sdk"][tag]
        end
      end
      return nil
    end

    def get_data_as_set(site, data)
      mappings = site.data["post-tag-mapping"]
      set = Set.new
      data.each do |tag|
        tag = tag.downcase.gsub(/\./, '')
        if /^feed_/ =~ tag then
          next
        end
        if tag.match(/^aerogear-(.*)$/) then
          tag = $1
        end
        mapped = mappings[tag]
        if mapped.nil? then
          set.add(tag)
        else
          case mapped
            when /^\+(.*)$/
              # add both, tag and mapped
              set.add($1)
              set.add(tag)
            when /^=/
              # add just tag itself for modules, it will be recognized and removed later
              set.add(tag)
            else
              # remove tag, use mapped
              set.add(mapped)
          end
        end
        set.delete('')
        set.delete(nil)
      end
      return set
    end

    def derive_classes(data, mod, platform, is_release)
      classes = Set.new
      unless platform.nil? then
        platformName = platform["name"].downcase
        classes.add("platform-#{platformName}")
      end
      unless mod.nil? then
        modName = mod["name"].downcase
        classes.add("module-#{modName}") unless mod.nil?
      end
      data.each do |tag|
        classes.add("tag-#{tag}")
      end
      classes.add("release") if is_release
      return classes.to_a.join(' ')
    end

    def include_blog_entry_in_news_feed(entry, categories)
      return categories.include? "aerogear" || entry.title.content =~ /aerogear/i || entry.summary.content =~ /aerogear/i;
    end
  end
end
