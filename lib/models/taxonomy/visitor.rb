class Taxonomy  
  class Visitor < XmlVisitor
    attr_accessor :taxonomy

    def enter_taxonomy(attrs)
      @taxonomy = Taxonomy.new
      node_stack.push taxonomy
    end

    def leave_taxonomy
      node_stack.pop
    end

    def taxonomy_name_text(text)      
      taxonomy.name = text
    end

    def enter_node(attrs)
      node = current_node.create_child
      
      node.atlas_id = attrs[:atlas_node_id]

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