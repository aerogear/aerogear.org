require 'external_layout.rb'
Awestruct::Extensions::Pipeline.new do
  # extension Awestruct::Extensions::Posts.new( '/news' ) 
  extension Awestruct::Extensions::ExternalLayout.new('/docs/guides', 'basic')
  extension Awestruct::Extensions::Indexifier.new
  helper Awestruct::Extensions::Partial
end

