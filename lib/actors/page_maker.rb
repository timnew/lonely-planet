class PageMaker

  attr_reader :taxonomy_nodes
  attr_reader :root_path, :render

  def initialize(root_path, render, taxonomy, destinations)
    @root_path = root_path
    @render = render
    @taxonomy_file = taxonomy
    @destinations_file = destinations
  end

  def load_taxonomy
    puts "Loading Taxonomy from #{@taxonomy_file}..."

    @taxonomy_nodes = TaxonomyNode.load @taxonomy_file

    puts "#{taxonomy_nodes.length} taxonomy nodes loaded."

    self
  end

  def run
    puts "Processing Destinations file at #{@destinations_file}..."

    Destination.load(self, @destinations_file)
  end

  def include?(atlas_id)
    result = taxonomy_nodes.has_key? atlas_id

    puts "Desination #{atlas_id} #{result ? 'included' : 'ignored'}"

    result
  end

  def new_destination(destination)
    taxonomy_node = taxonomy_nodes[destination.atlas_id]
    page = Page.new root_path, taxonomy_node, destination

    puts "Rendering page for #{destination.title} at #{page.file_path}..."

    render.render page
  end
end