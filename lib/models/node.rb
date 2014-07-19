class Node
  attr_accessor :parent, :children
  attr_accessor :atlas_id, :name

  def initialize 
    @children = []
  end

  def create_child
    child = Node.new
    
    children << child
    child.parent = self

    child
  end
end