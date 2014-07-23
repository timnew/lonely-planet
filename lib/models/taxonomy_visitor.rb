class TaxonomyVisitor < XmlVisitor
  attr_reader :nodes

  def initialize
    super
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.atlas_id] = node
  end

  def enter_node(attrs)
    node = TaxonomyNode.new current_node, attrs[:atlas_node_id]

    add_node node

    node_stack.push node
  end

  def leave_node
    node_stack.pop
  end

  def node_name_text(text)
    current_node.name = text
  end
end
