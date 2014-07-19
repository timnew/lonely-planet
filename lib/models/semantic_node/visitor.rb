class SemanticNode
  class Visitor < Nokogiri::XML::SAX::Document
    attr_reader :node_stack

    def current_node
      node_stack.last
    end

    def root_node
      node_stack.first
    end

    def initialize
      @node_stack = [SemanticNode.new]
    end

    def start_element(name, attrs)
      @node_stack.push current_node[name]
      current_node.visit
    end

    def end_element(name)
      @node_stack.pop.leave
    end
  end
end