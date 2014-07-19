describe Taxonomy do

  it 'should create taxonomy node' do
    child = subject.create_child

    child.should be_an_instance_of Taxonomy::TaxonomyNode

    subject.children.first.should == child
    child.parent.should == subject
  end

  describe 'factory methods' do

    let(:xml) { File.open(File.join(File.dirname(__FILE__), '../taxonomy.xml')) }

    it 'should load from file', :smoke do
      taxonomy = Taxonomy.parse xml
      taxonomy.name.should == 'World'
      taxonomy.children.length.should == 1

      africa = taxonomy.children.first
      africa.name.should == 'Africa'
      africa.atlas_id.should == '355064'
      africa.children.length.should == 3

      south_africa = africa.children.first
      south_africa.name.should == 'South Africa'
      south_africa.atlas_id.should == '355611'
      south_africa.children.length.should == 7

      cape_town = south_africa.children.first
      cape_town.name.should == 'Cape Town'
      cape_town.atlas_id.should == '355612'
      cape_town.children.length.should == 1

      national_park = cape_town.children.first
      national_park.name.should == 'Table Mountain National Park'
      national_park.atlas_id.should == '355613'
      national_park.children.should be_empty

      garden_route = south_africa.children.last
      garden_route.name.should == 'The Garden Route'
      garden_route.atlas_id.should == '355626'
      garden_route.children.length.should == 2

      swaziland = africa.children.last
      swaziland.name.should == 'Swaziland'
      swaziland.atlas_id.should == '355633'
      swaziland.children.should be_empty
    end
  end
end