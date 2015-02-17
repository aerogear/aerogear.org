require 'rss'
require 'curb'
require 'diskcached'
require 'json'
require 'base64'

module Readme
  class Generator < Jekyll::Generator

    def generate(site)
      # feed_xml = diskcache.cache('readme') do
      url = 'https://api.github.com/repos/aerogear/aerogear-android-cookbook/readme'
      http = Curl.get( url ) do |http|
        http.headers['User-Agent'] = 'Jekyll'
      end
      json = JSON.parse(http.body_str)

      # end

      baseurl = File.dirname(json['html_url'])

      content = Base64.decode64(json['content'])
      tocIndex = content.index('## Cookbook apps') + 16
      content = content[tocIndex..-1]
      nextHeadingIndex = content.index('##') - 1
      content = content[0..nextHeadingIndex]

      content = content.gsub(/:heavy_check_mark:/, '<i class="fa fa-check green"></i>')
      content = content.gsub(/:heavy_minus_sign:/, '<i class="fa fa-remove gray"></i>')
      content = content.gsub(/\[([^\]]+)\]\(([^\)]+)\)/, '[\1](' + baseurl + '/\2)')

      site.data['cookbooks'] = {}
      site.data['cookbooks']['android'] = content
    end

  end
end