class Taxonomy  
  class Visitor < XmlVisitor
    attr_accessor :taxonomy

    def initialize
      super
      @taxonomy = Taxonomy.new
    end

    def enter_node(attrs)
      node = TaxonomyNode.new current_node, attrs[:atlas_node_id]

      taxonomy.add_node node

      node_stack.push node
    end

    def leave_node
      node_stack.pop
    end

    def node_name_text(text)
      current_node.name = text
    end
  end
end