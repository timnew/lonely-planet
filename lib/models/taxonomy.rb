class Taxonomy
  attr_accessor :name
  attr_accessor :nodes

  def initialize
    @nodes = []
  end
end