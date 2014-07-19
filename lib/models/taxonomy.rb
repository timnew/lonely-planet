class Taxonomy
  attr_accessor :name, :parent, :children

  def initialize 
    @children = []
  end
end