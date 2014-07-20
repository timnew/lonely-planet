class SemanticNode
  class Visitor < XmlVisitor
    def initialize
      super SemanticNode.new
    end

    def generic_enter(name, attrs)
      node_stack.push current_node[name].visit
    end

    def generic_leave(name)
      node_stack.pop.leave
    end
  end
end