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
    if current_node.nil?
      node = TaxonomyNode.new attrs[:atlas_node_id]
    else
      node = current_node.create_child attrs[:atlas_node_id]
    end

    add_node node
    node_stack.push node
  end

  def leave_node
    node_stack.pop
  end

  def node_name_text(text)
    current_node.display_name = text
  end
end
