describe TaxonomyNode do

  subject { TaxonomyNode.new '1' }

  it 'should alias atlas_id with name' do
    subject.atlas_id.should == '1'
    subject.name.should == subject.atlas_id
  end

  it 'should iterate each parent' do
    parents = []

    subject
    .create_child('11')
    .create_child('111')
    .create_child('self')
    .each_parent do |parent|
      parents.unshift parent.atlas_id
    end

    parents.should contain_exactly '1', '11', '111'
  end

  it 'should build path' do
    child1 = subject

    child1.display_name = 'Australia'

    child11 = child1.create_child('11')
    child11.display_name = 'Victoria'

    child111 = child11.create_child('111')
    child111.display_name = 'Melbourne'

    child111.get_path.should == 'Australia/Victoria/Melbourne'
  end

  describe 'factory methods' do

    let(:xml) { File.join(File.dirname(__FILE__), '../taxonomy.xml') }

    it 'should load from file', :smoke do
      nodes = TaxonomyNode.load xml

      africa = nodes.values.first
      africa.display_name.should == 'Africa'
      africa.atlas_id.should == '355064'
      africa.children.length.should == 3

      south_africa = africa.children.values.first
      south_africa.display_name.should == 'South Africa'
      south_africa.atlas_id.should == '355611'
      south_africa.children.length.should == 7
      nodes[south_africa.atlas_id].should == south_africa

      cape_town = south_africa.children.values.first
      cape_town.display_name.should == 'Cape Town'
      cape_town.atlas_id.should == '355612'
      cape_town.children.length.should == 1
      nodes[cape_town.atlas_id].should == cape_town

      national_park = cape_town.children.values.first
      national_park.display_name.should == 'Table Mountain National Park'
      national_park.atlas_id.should == '355613'
      national_park.children.should be_empty
      nodes[national_park.atlas_id].should == national_park

      garden_route = south_africa.children.values.last
      garden_route.display_name.should == 'The Garden Route'
      garden_route.atlas_id.should == '355626'
      garden_route.children.length.should == 2
      nodes[garden_route.atlas_id].should == garden_route

      swaziland = africa.children.values.last
      swaziland.display_name.should == 'Swaziland'
      swaziland.atlas_id.should == '355633'
      swaziland.children.should be_empty
      nodes[swaziland.atlas_id].should == swaziland
    end
  end

end
