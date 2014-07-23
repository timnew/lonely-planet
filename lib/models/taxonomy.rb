class Taxonomy
  def add_node(node)
    @nodes[node.atlas_id] = node
  end

  def initialize
    @nodes = {}
  end

  def flatten
    @nodes
  end

  def self.load(file)
    visitor = Visitor.new

    parser = Nokogiri::XML::SAX::Parser.new(visitor)

    parser.parse File.open(file)

    visitor.taxonomy
  end
end