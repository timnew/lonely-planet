class Taxonomy  
  class Visitor < Node::XmlVisitor
    attr_accessor :taxonomy

    def start_taxonomy(attrs)
      @taxonomy = Taxonomy.new
      node_stack.push taxonomy
    end

    def end_taxonomy
      node_stack.pop
    end

    def taxonomy_name_text(text)      
      taxonomy.name = text
    end

    def start_node(attrs)
      node = current_node.create_child
      
      node.atlas_id = attrs[:atlas_node_id]

      node_stack.push node
    end

    def end_node
      node_stack.pop
    end

    def node_name_text(text)
      current_node.name = text
    end
  end
end