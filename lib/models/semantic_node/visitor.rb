class SemanticNode
  class Visitor < Node::XmlVisitor
    def root_node
      node_stack.first
    end

    def initialize
      super
      node_stack.push SemanticNode.new
    end

    def generic_enter(name, attrs)
      node_stack.push current_node[name].visit
    end

    def generic_leave(name)
      node_stack.pop.leave
    end
  end
end