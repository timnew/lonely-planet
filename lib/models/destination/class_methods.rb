class Destination
  module ClassMethods
    def load(listener, file)
      parse listener, File.open(file)
    end

    def parse(listener, xml)
      visitor = Visitor.new listener

      parser = Nokogiri::XML::SAX::Parser.new visitor

      parser.parse xml
    end
  end
end