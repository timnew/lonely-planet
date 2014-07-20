class PageMaker

  attr_reader :taxonomy_nodes

  def initialize(taxonomy, destinations, render)
    @taxonomy_file = taxonomy
    @destinations_file = destinations
    @render = render
  end

  def load_taxonomy
    taxonomy = Taxonomy.load @taxonomy_file
    @taxonomy_nodes = taxonomy.flatten
    self
  end

  def run
    Destination.load(self, @destinations_file)
  end

  def included?(atlas_id)
    taxonomy_nodes.has_key? atlas_id.to_sym
  end

  def new_destination(destination)
    taxonomy_node = taxonomy_nodes[destination.atlas_id]
    page = Page.new taxonomy_node, destination

    render.render page
  end
end