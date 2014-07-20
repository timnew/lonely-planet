class Page
  extend CachedAttrs

  attr_reader :taxonomy_node, :destination

  def initialize(output_path, root_path, taxonomy_node, destination)
    @output_path = output_path
    @root_path = root_path
    @taxonomy_node = taxonomy_node
    @destination = destination
  end

  attr_reader :output_path, :root_path

  def path_for_node(base_path, taxonomy_node)
    File.join(base_path, "#{taxonomy_node.get_path}/index.html")
  end

  def file_path
    path_for_node(output_path, taxonomy_node)
  end

  cached_attr :title do
    taxonomy_node.name
  end

  cached_attr :navigation_items do
    result = []

    taxonomy_node.each_parent do |parent|
      result.unshift NavigationItem.from_taxonomy_node(self, parent, 'fa-level-up')
    end

    result.push NavigationItem.new('#', taxonomy_node.name, 'fa-smile-o')

    taxonomy_node.children.each_value do |child|
      result.push NavigationItem.from_taxonomy_node(self, child, 'fa-level-down')
    end

    result
  end

  cached_attr :sections do
    result = []

    if destination.has_child? :history
      history = destination.history.history
      result << Section.new(history.name, history.values[:overview], history.values[:history])
    end
    result
  end
end