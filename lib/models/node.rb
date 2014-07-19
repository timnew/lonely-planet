class Node
  attr_accessor :parent, :children
  attr_accessor :name

  def initialize 
    @children = []
  end

  def create_child
    add_child self.class.new
  end

  def add_child(child)
    children << child
    child.parent = self

    child
  end
end