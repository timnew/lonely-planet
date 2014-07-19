class Node
  attr_accessor :parent, :children
  attr_accessor :atlas_id, :name

  def initialize 
    @children = []
  end
end