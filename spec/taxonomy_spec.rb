describe Taxonomy::TaxonomyNode do
  subject { Taxonomy::TaxonomyNode.new '10010' }

  it 'should create initialized with atlas_id' do
    subject.atlas_id.should == '10010'
  end

  it 'should infer child name from atlas_id' do
    child = Taxonomy::TaxonomyNode.new '20000'

    subject.add_child child

    subject.children[:'20000'].should == child
  end

  it 'should create child' do
    subject.create_child '20000'

    subject.children.length.should == 1

    child = subject.children[:'20000']
    child.should_not be_nil
    child.atlas_id.should == '20000'
  end
end

describe Taxonomy do

  it 'should create taxonomy node' do
    child = subject.create_child '10010'

    child.should be_an_instance_of Taxonomy::TaxonomyNode
    child.atlas_id.should == '10010'

    subject.children[:'10010'].should == child
    child.parent.should == subject
  end

  it 'should flatten taxonomy hierarchy' do
    child1 = subject.create_child('1')
    child1.create_child('11')
    child1.create_child('12').create_child('121')
    subject.create_child('2')

    children = subject.flatten
    children.keys.should contain_exactly *%w{1 11 12 121 2}
  end

  describe 'factory methods' do

    let(:xml) { File.open(File.join(File.dirname(__FILE__), '../taxonomy.xml')) }

    it 'should load from file', :smoke do
      taxonomy = Taxonomy.parse xml
      taxonomy.name.should == 'World'
      taxonomy.children.length.should == 1

      africa = taxonomy.children.values.first
      africa.name.should == 'Africa'
      africa.atlas_id.should == '355064'
      africa.children.length.should == 3

      south_africa = africa.children.values.first
      south_africa.name.should == 'South Africa'
      south_africa.atlas_id.should == '355611'
      south_africa.children.length.should == 7

      cape_town = south_africa.children.values.first
      cape_town.name.should == 'Cape Town'
      cape_town.atlas_id.should == '355612'
      cape_town.children.length.should == 1

      national_park = cape_town.children.values.first
      national_park.name.should == 'Table Mountain National Park'
      national_park.atlas_id.should == '355613'
      national_park.children.should be_empty

      garden_route = south_africa.children.values.last
      garden_route.name.should == 'The Garden Route'
      garden_route.atlas_id.should == '355626'
      garden_route.children.length.should == 2

      swaziland = africa.children.values.last
      swaziland.name.should == 'Swaziland'
      swaziland.atlas_id.should == '355633'
      swaziland.children.should be_empty
    end
  end

end