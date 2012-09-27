require 'open3'
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
      cmd = "asciidoc -s -b html5 -a pygments -a imagesdir='../' -o - -"
      Open3.popen3(cmd) do |stdin, stdout, _|
        stdin.puts content
        stdin.close
        out = stdout.read
      end
    end
  end
end
