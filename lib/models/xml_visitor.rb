class XmlVisitor < Nokogiri::XML::SAX::Document
  attr_reader :element_stack, :node_stack

  def current_element
    element_stack.last
  end

  def parent_element
    element_stack[-2]
  end

  def current_node
    node_stack.last
  end

  def parent_node
    node_stack[-2]
  end

  def root_node
    node_stack.first
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

  def skip_current_element
    @skip_level = element_stack.length
  end

  def update_skip
    @skip_level = nil unless skip?
  end

  def skip?
    !@skip_level.nil? and @skip_level <= element_stack.length
  end

  def start_element(name, attrs = [])
    element_stack.push name

    return if skip?

    # noinspection RubyHashKeysTypesInspection
    attrs_obj = Hash[attrs].symbolize_keys!

    delegate_to :"enter_#{name}", attrs_obj
    generic_enter(name, attrs_obj)
  end

  def generic_enter(name, attrs)
  end

  def end_element(name)
    unless skip?
      delegate_to :"leave_#{name}"
      generic_leave(name)
    end

    element_stack.pop
    update_skip
  end

  def generic_leave(name)
  end

  def characters(text)
    return if skip?

    delegate_to :"#{current_element}_text", text
  end

  def cdata_block(text)
    return if skip?

    delegate_to :"#{current_element}_cdata", text
    generic_cdata(text)
  end

  def generic_cdata(text)
  end
end
