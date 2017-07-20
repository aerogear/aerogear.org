module Jekyll
  class NavigationItem < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end
    def render(context)
      page = context['page']
      provided_url = context[@text]
      current_url = page['url'].gsub('/index.html', '')
      if provided_url == '/'
        provided_url = ''
      end

      return "active" if current_url == provided_url
      ""
    end
  end
end
Liquid::Template.register_tag('is_active_navigation_item', Jekyll::NavigationItem)
