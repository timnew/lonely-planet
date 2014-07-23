class Page
  extend CachedAttrs

  attr_reader :root_path, :taxonomy_node, :destination

  def initialize(root_path, taxonomy_node, destination)
    @root_path = root_path
    @taxonomy_node = taxonomy_node
    @destination = destination
  end

  cached_attr :file_path do
    path_for_node(taxonomy_node)
  end

  cached_attr :title do
    taxonomy_node.display_name
  end

  cached_array_attr :navigation_items do |items|
    taxonomy_node.each_parent do |parent|
      items.unshift NavigationItem.new path_for_node(parent), parent.display_name, 'fa-level-up'
    end

    items.push NavigationItem.new '#', taxonomy_node.display_name, 'fa-smile-o'

    taxonomy_node.children.each_value do |child|
      items.push NavigationItem.new path_for_node(child), child.display_name, 'fa-level-down'
    end
  end

  cached_attr :sections do
    @sections = []

    section :introductory, :introduction do |introduction|
      Section.new 'Introduction' do
        block introduction.values[:overview]
      end
    end

    section :history, :history do |history|
      Section.new 'History' do
        block history.values[:overview]
        extra_block history.values[:history]
      end
    end

    section :weather, :when_to_go do |when_to_go|
      Section.new 'When To Go' do
        block 'Overview', when_to_go.values[:overview]
        block 'Climate', when_to_go.values[:climate], limit: when_to_go.values[:overview].empty? ? nil : 1
      end
    end

    section :transport, :getting_there_and_around do |transport|
      Section.new 'Transport - Getting there and around' do
        block transport.values[:overview]

        block 'Air', transport.values[:air], limit: 2
        block 'Train', transport.values[:train], limit: 2
        block 'Boat', transport.values[:boat], limit: 2
        block 'Hitching', transport.values[:hitching], limit: 2

        block 'Car and Motorcyle', transport.values[:car_and_motorcycle], limit: 2
        block 'Bus and Tram', transport.values[:bus_and_tram], limit: 2

        block 'Local Transport', transport.values[:local_transport], limit: 2

        block 'Bicycle', transport.values[:bicycle], limit: 2
      end
    end

    section :transport, :getting_there_and_away do |transport|
      Section.new 'Transport - Getting there and away' do
        block transport.values[:overview]

        block 'Air', transport.values[:air], limit: 2
        block 'Land', transport.values[:land], limit: 2
        block 'Bus and Tram', transport.values[:bus_and_tram], limit: 2
      end
    end

    section :transport, :getting_around do |transport|
      Section.new 'Transport - Getting around' do
        block transport.values[:overview]

        block 'Air', transport.values[:air], limit: 2
        block 'Train', transport.values[:train], limit: 2

        block 'Car and Motorcyle', transport.values[:car_and_motorcycle], limit: 2
        block 'Bus and Tram', transport.values[:bus_and_tram], limit: 2

        block 'Local Transport', transport.values[:local_transport], limit: 2

        block 'Bicycle', transport.values[:bicycle], limit: 2

      end
    end

    section :practical_information, :health_and_safety do |health_and_safety|
      Section.new 'Health And Safety' do
        block 'Before You Go', health_and_safety.values[:before_you_go], limit: 2
        block 'Dangers And Annoyances', health_and_safety.values[:dangers_and_annoyances], limit: 2
        block 'In Transit', health_and_safety.values[:in_transit], limit: 2
        block 'While You\'re there', health_and_safety.values[:while_youre_there], limit: 2

      end
    end

    section :practical_information, :visas do |visas|
      Section.new 'Visas' do
        block visas.values[:overview]
        extra_block visas.values[:other]
        block 'Permits', visas.values[:permits]
      end
    end

    section :practical_information, :money_and_costs do |money_and_costs|
      Section.new 'Money and Costs' do

        block 'Costs', money_and_costs.values[:costs]
        block 'Money', money_and_costs.values[:money]

      end
    end

    section :work_live_study, :work do |work|
      Section.new 'Work' do

        block work.values[:overview]
        block 'Business', work.values[:business]

      end
    end

    section :wildlife do |wildlife|
      Section.new 'Wildlife' do

        if wildlife.has_child?(:overview)
          block wildlife[:overview].values[:overview]
        end

        if wildlife.has_child?(:endangered_species)
          block 'Endangerd Species', wildlife[:endangered_species].values[:overview]
        end

        if wildlife.has_child?(:animals)
          block 'Animals', wildlife[:animals].values[:overview]
        end

        if wildlife.has_child?(:birds)
          block 'Birds', wildlife[:birds].values[:overview]
        end

        if wildlife.has_child?(:plants)
          block 'Plants', wildlife[:plants].values[:overview]
        end

      end
    end

    @sections
  end

  protected

  def path_for_node(taxonomy_node)
    File.join(root_path, "#{taxonomy_node.get_path}/index.html")
  end

  def section(*names)
    current = destination[*names]

    if current.nil?
      section_result = nil
    else
      section_result = yield current
    end

    @sections << section_result unless section_result.nil?
  rescue Exception => ex
    puts "ERROR: #{ex}" # Guard to avoid crash
  end
end