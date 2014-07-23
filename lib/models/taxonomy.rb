class Taxonomy < Node
  include SharedBehaviors

  def initialize
    super 'Taxonomy'
  end

  def flatten
    result = {}

    flatten_children(result)

    result
  end

  def self.load(file)
    visitor = Visitor.new

    parser = Nokogiri::XML::SAX::Parser.new(visitor)

    parser.parse File.open(file)

    visitor.taxonomy
  end
end