class Taxonomy  
  class Visitor < Nokogiri::XML::SAX::Document
    attr_reader :taxonomy

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

      visit_method = :"start_#{name}"

      if respond_to?(visit_method)
        send visit_method, Hash[attrs].symbolize_keys!
      end
    end

    def end_element(name)
      element_stack.pop

      visit_method = :"end_#{name}"
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