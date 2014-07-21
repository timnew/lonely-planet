class Page
  extend CachedAttrs
  extend SectionDSL
  include ViewModelBuilder::DSL

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

  def url_for_node(taxonomy_node)
    path_for_node(root_path, taxonomy_node)
  end

  cached_attr :file_path do
    path_for_node(output_path, taxonomy_node)
  end

  cached_attr :title do
    taxonomy_node.name
  end

  cached_array_attr :navigation_items do |items|
    taxonomy_node.each_parent do |parent|
      item = build(NavigationItem) do
        href url_for_node(parent)
        text parent.name
        icon 'fa-level-up'
      end

      items.unshift item
    end

    item = build NavigationItem do
      href '#'
      text taxonomy_node.name
      icon 'fa-smile-o'
    end
    items.push item

    taxonomy_node.children.each_value do |child|
      item = build(NavigationItem) do
        href url_for_node(child)
        text child.name
        icon 'fa-level-down'
      end
      items.push item
    end
  end

  declare_sections do

    section :introductory, :introduction do |introduction|
      build Section do
        title introduction.name
        paragraphs introduction.values[:overview]
      end
    end

    section :history, :history do |history|
      build Section do
        title history.name
        paragraphs history.values[:overview]
        extra_paragraphs history.values[:history]
      end
    end
  end
end