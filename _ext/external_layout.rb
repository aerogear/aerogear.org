module Awestruct
  module Extensions
    class ExternalLayout
      def initialize(path_prefix, layout)
        @path_prefix = path_prefix
        @layout = layout
      end

      def execute(site)
        site.pages.each do |page|
          if(page.relative_source_path =~ /^#{@path_prefix}\//)
            page.layout = @layout
          end
        end
      end
    end
  end
end
