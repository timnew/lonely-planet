class TaxonomyNode < Node
  alias_attribute :atlas_id, :name
  attr_accessor :display_name

  def each_parent(&block)
    return if parent.nil?

    yield parent

    parent.each_parent(&block)
  end

  def get_path
    parts = [display_name]

    each_parent do |parent|
      parts.unshift parent.display_name
    end

    parts.join('/')
  end

  def self.load(file)
    visitor = TaxonomyVisitor.new

    parser = Nokogiri::XML::SAX::Parser.new(visitor)

    parser.parse File.open(file)

    visitor.nodes
  end
end
