module Jekyll
  class NavigationItem < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end
    def render(context)
      page = context['page']
      return "active" if context[@text] == page['url'].gsub('/index.html', '')
      ""
    end
  end
end
Liquid::Template.register_tag('is_active_navigation_item', Jekyll::NavigationItem)
