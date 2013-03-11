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
      Asciidoctor.load(content, {:attributes => {'imagesdir' => '../'}}).render
    end
  end
end
