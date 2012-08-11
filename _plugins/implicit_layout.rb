module Jekyll
  module Convertible
    alias_method :original_read_yaml, :read_yaml
    def read_yaml(base, name)
      if name =~ /asciidoc/
        self.content = File.read(File.join(base, name))
        self.data = {"layout" => "base"} 
      else
        original_read_yaml(base, name)
      end
    end
  end
end