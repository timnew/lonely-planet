class DestinationVisitor < XmlVisitor
  IGNORE_LIST = %w{destinations destination}

  attr_reader :listener

  def initialize(listener)
    super()
    @listener = listener
  end

  def enter_destination(attrs)
    unless listener.include? attrs[:atlas_id]
      skip_current_element
      return
    end

    node_stack.push Destination.new attrs
  end

  def leave_destination
    listener.new_destination node_stack.pop
  end

  def generic_enter(name, attrs)
    return if IGNORE_LIST.include? name

    parent_node.add_child current_node unless parent_node.nil? # Only add child when current_node is comfirmed not a leave node
    node_stack.push DestinationNode.new name
  end

  def generic_leave(name)
    node_stack.pop
  end

  def generic_cdata(text)
    parent_node.add_value current_node.name, text
  end
end
