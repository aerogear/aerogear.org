require 'asciidoctor'
require 'asciidoctor/extensions'

class TabsBlock < Asciidoctor::Extensions::BlockProcessor
  option :contexts, [:paragraph]
  option :content_model, :simple

  def process parent, reader, attributes
    source =  '<ul class="nav nav-tabs">'
    if (!options['index'])
      options['index'] = 0
    else 
      options['index'] += 1
    end
    tabNames = attributes['names'].split(',')
    tabNames.each_with_index do |code,i|
      source << "<li #{(i == 0 ? 'class="active"' : '')}><a href='\##{code.downcase + options['index'].to_s}' data-toggle='tab'>#{code}</a></li>"
    end

    source << '</ul><div class="tab-content">'

    lines = reader.lines.collect! { |element|
    element.strip
  }

  source << (Asciidoctor.render lines)
  source << '</div>'

    Asciidoctor::Block.new parent, :pass, :content_model => :raw, :source => source
  end
end

Asciidoctor::Extensions.register do |document|
  if document.basebackend? 'html'
      block :tabs, TabsBlock
  end
end

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
