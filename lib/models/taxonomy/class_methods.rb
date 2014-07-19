class Taxonomy  
  module ClassMethods
    def load(file)
      parse File.open(file)
    end

    def parse(xml)
      visitor = Visitor.new

      parser = Nokogiri::XML::SAX::Parser.new(visitor)

      parser.parse xml

      visitor.taxonomy
    end
  end
end