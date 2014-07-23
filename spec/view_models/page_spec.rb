describe Page do
  let(:taxonomy_node) do
    africa = TaxonomyNode.new('12345')
    africa.display_name = 'Africa'

    south_africa = africa.create_child('54321')
    south_africa.display_name = 'South Africa'

    cape_town = south_africa.create_child('12321')
    cape_town.display_name = 'Cape Town'

    south_africa
  end

  let(:destination) do
    Destination.new atlas_id: '10010', title: 'South Africa', :'title_ascii' => 'south africa'
  end

  let(:root_path) { '/output' }

  subject { Page.new(root_path, taxonomy_node, destination) }

  it 'should initialize with parameters' do
    subject.root_path.should == root_path
    subject.taxonomy_node.should == taxonomy_node
    subject.destination.should == destination
  end

  describe 'values for view rendering', :smoke do
    it 'should populate file path' do
      subject.file_path.should == '/output/Africa/South Africa/index.html'
    end

    it 'should populate title', :smoke do
      subject.title.should == 'South Africa'
    end

    describe 'navigation items' do
      it 'should populate correct navigation items', :smoke do
        subject.navigation_items.map { |i| i.text }.should contain_exactly 'Africa', 'South Africa', 'Cape Town'
      end

      it 'should populate correct icons', :smoke do
        subject.navigation_items.map { |i| i.icon }.should contain_exactly 'fa-level-down', 'fa-level-up', 'fa-smile-o'
      end
    end
  end

  describe 'sections population' do

    # Sections are the page definition
    # Its underline implementation is covered by either section dsl tests and other model tests
    # Itself is just the page configuration, no need to test
    it 'should populate sections', :smoke do
      subject.sections.should be_an_instance_of Array
    end
  end
end