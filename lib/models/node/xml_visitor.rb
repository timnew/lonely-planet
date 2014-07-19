class Node
  class XmlVisitor < Nokogiri::XML::SAX::Document
    attr_reader :element_stack, :node_stack

    def current_element
      element_stack.last
    end

    def current_node
      node_stack.last
    end

    def initialize
      @element_stack = []
      @node_stack = []
    end

    def start_element(name, attrs = [])
      element_stack.push name

      visit_method = :"enter_#{name}"

      if respond_to?(visit_method)
        send visit_method, Hash[attrs].symbolize_keys!
      end
    end

    def end_element(name)
      element_stack.pop

      visit_method = :"leave_#{name}"
      if respond_to?(visit_method)
        send visit_method
      end
    end

    def characters(text)
      visit_method = :"#{current_element}_text"
      if respond_to?(visit_method)
        send visit_method, text
      end
    end
  end
end