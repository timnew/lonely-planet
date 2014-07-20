class Page

  attr_reader :taxonomy_node, :destination

  def initialize(taxonomy_node, destination)
    @taxonomy_node = taxonomy_node
    @destination = destination
  end

  def get_path
    taxonomy_node.get_path
  end
end