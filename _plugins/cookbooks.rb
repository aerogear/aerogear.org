require 'rss'
require 'curb'
require 'diskcached'
require 'json'
require 'base64'

module Readme
  class Generator < Jekyll::Generator

    def generate(site)

      cookbooks = {
          "android" => "https://api.github.com/repos/aerogear/aerogear-android-cookbook/readme",
          "ios" => "https://api.github.com/repos/aerogear/aerogear-ios-cookbook/readme",
          "cordova" => "https://api.github.com/repos/aerogear/aerogear-cordova-cookbook/readme",
          "windows" => "https://api.github.com/repos/aerogear/aerogear-windows-cookbook/readme",
          "js" => "https://api.github.com/repos/aerogear/aerogear-js-cookbook/readme"
      }

      diskcache = Diskcached.new('/tmp/aerogear.site.cache', 3000)

      cookbooks.each do |platform, url|
        body_str = diskcache.cache('cookbook-' + platform) do
          Jekyll.logger.info "cookbooks:", "fetching #{url}"
          http = Curl.get( url ) do |http|
            http.headers['User-Agent'] = 'Jekyll'
          end
          http.body_str
        end

        json = JSON.parse(body_str)
        baseurl = File.dirname(json['html_url'])
        content = Base64.decode64(json['content'])


        content = content.gsub(/^.*(?:Cookbook apps|Table of content)([^#]+)(?:##.*$|$)/m, '\1')
        content = content[0..content.rindex('|')]
        content = content.gsub(/:heavy_check_mark:/, '<i class="fa fa-check green"></i>')
        content = content.gsub(/:heavy_minus_sign:/, '<i class="fa fa-remove gray"></i>')
        content = content.gsub(/\[([^\]]+)\]\(((?!http).+)\)/, '[\1](' + baseurl + '/\2)')

        site.data['cookbooks'] = {} unless site.data['cookbooks']
        site.data['cookbooks'][platform] = content
      end
    end

  end
end