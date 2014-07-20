class PageMaker

  attr_reader :taxonomy_nodes, :render

  def initialize(taxonomy, destinations, render)
    @taxonomy_file = taxonomy
    @destinations_file = destinations
    @render = render
  end

  def load_taxonomy
    puts "Loading Taxonomy from #{@taxonomy_file}..."

    taxonomy = Taxonomy.load @taxonomy_file
    @taxonomy_nodes = taxonomy.flatten

    puts "#{taxonomy_nodes.length} taxonomy nodes loaded."

    self
  end

  def run
    puts "Processing Destinations file at #{@destinations_file}..."

    Destination.load(self, @destinations_file)
  end

  def included?(atlas_id)
    result = taxonomy_nodes.has_key? atlas_id

    puts "Desination #{atlas_id} #{result ? 'included' : 'ignored'}"

    result
  end

  def new_destination(destination)
    taxonomy_node = taxonomy_nodes[destination.atlas_id]
    page = Page.new taxonomy_node, destination

    puts "Rendering page for #{destination.title} at #{page.get_path}..."

    render.render page
  end
end