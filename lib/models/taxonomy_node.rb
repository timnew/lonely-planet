class TaxonomyNode < Node
  def create_child(atlas_id)
    add_child TaxonomyNode.new atlas_id
  end

  def add_child(child)
    super(child, child.atlas_id)
  end

  def flatten_children(container)
    children.each_value do |child|
      container[child.atlas_id] = child
      child.flatten_children(container)
    end
  end

  attr_accessor :atlas_id

  def initialize(parent, atlas_id)
    super ''
    self.parent = parent
    parent.children[atlas_id] = self unless parent.nil?
    @atlas_id = atlas_id
  end

  def each_parent(&block)
    return if parent.nil?

    yield parent

    parent.each_parent(&block)
  end

  def get_path
    parts = [name]

    each_parent do |parent|
      parts.unshift parent.name
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
