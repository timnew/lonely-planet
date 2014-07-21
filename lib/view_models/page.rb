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
        block introduction.values[:overview]
      end
    end

    section :history, :history do |history|
      build Section do
        title history.name
        block history.values[:overview]
        extra_block history.values[:history]
      end
    end

    section :weather, :when_to_go do |when_to_go|
      build Section do
        title 'When To Go'
        block 'Overview', when_to_go.values[:overview]
        block 'Climate', when_to_go.values[:climate], limit: when_to_go.values[:overview].empty? ? nil : 1
      end
    end

    section :practical_information, :health_and_safety do |health_and_safety|
      build Section do
        title 'Health And Safety'
        block 'Before You Go', health_and_safety.values[:before_you_go], limit: 2
        block 'Dangers And Annoyances', health_and_safety.values[:dangers_and_annoyances], limit: 2
        block 'In Transit', health_and_safety.values[:in_transit], limit: 2
        block 'While You\'re there', health_and_safety.values[:while_youre_there], limit: 2
      end
    end

    section :practical_information, :visas do |visas|
      build Section do
        title 'Visas'
        block visas.values[:overview]
        extra_block visas.values[:other]
        block 'Permits', visas.values[:permits]
      end
    end
  end
end