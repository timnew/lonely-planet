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

    def delegate_to(method_name, *args)
      return if method_name.nil?

      if respond_to? method_name
        send method_name, *args
      end
    end

    def current_element_path(depth = 2)
      name_parts = element_stack[-depth..-1]

      return nil if name_parts.nil?

      name_parts.join('_')
    end

    def start_element(name, attrs = [])
      element_stack.push name

      # noinspection RubyHashKeysTypesInspection
      attrs_obj = Hash[attrs].symbolize_keys!

      delegate_to :"enter_#{name}", attrs_obj
      delegate_to :generic_enter, name, attrs_obj
    end

    def end_element(name)
      element_stack.pop

      delegate_to :"leave_#{name}"
      delegate_to :generic_leave, name
    end

    def characters(text)
      delegate_to :"#{current_element}_text", text
    end

    def cdata_block(text)
      delegate_to :"#{current_element}_cdata", text
    end
  end
end