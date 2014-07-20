class SemanticNode
  class Visitor < XmlVisitor
    def initialize
      super SemanticNode.new
    end

    def generic_enter(name, attrs)
      node = current_node[name]
      node.visit
      node_stack.push node
    end

    def generic_leave(name)
      node_stack.pop.leave
    end
  end
end