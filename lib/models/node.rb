class Node
  attr_accessor :parent, :children
  attr_accessor :name

  def initialize(name, children = {})
    @name = name
    @children = children
  end

  def create_child(name)
    add_child self.class.new(name)
  end

  def add_child(child, name = nil)
    name = child.name if name.nil?
    children[name.to_sym] = child
    child.parent = self

    child
  end
end