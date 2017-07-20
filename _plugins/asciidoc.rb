require 'asciidoctor'
module Jekyll
  class AsciiDoc < Converter
    safe true

    def matches(ext)
      ext =~ /asciidoc/
    end

    def output_ext(ext)
      '/index.html'
    end

    def convert(content)
      Asciidoctor.load(content, :safe => 0, :attributes => {'imagesdir' => '../', 'allow-uri-read' => true, 'icons' => 'font'}).render
    end
  end
end
