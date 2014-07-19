describe Taxonomy::Visitor do

  subject do
    visitor = Taxonomy::Visitor.new

    visitor.start_element 'taxonomy'

    visitor
  end

  let(:taxonomy) { subject.taxonomy }

  let(:first_node) { taxonomy.children.first }

  it 'should instantiate taxonomy' do
    taxonomy.should be_an_instance_of Taxonomy
  end

  it 'should set taxonomy name' do
    subject.start_element 'taxonomy_name'
    subject.characters 'taxonomy'
    subject.end_element 'taxonomy_name'

    taxonomy.name.should == 'taxonomy'
  end

  it 'should instantiate node' do
    subject.start_element 'node', [['atlas_node_id', '1']]
    
    first_node.should be_an_instance_of Taxonomy::TaxonomyNode
    first_node.atlas_id.should == '1'
  end

  it 'should create node hierarchy' do
    subject.start_element 'node', [['atlas_node_id', '1']]      
    subject.start_element 'node', [['atlas_node_id', '11']]
    subject.end_element 'node'
    subject.start_element 'node', [['atlas_node_id', '12']]
    subject.end_element 'node'
    subject.end_element 'node'

    first_node.children.length.should == 2
    
    first_node.children.first.atlas_id.should == '11'
    first_node.children.last.atlas_id.should == '12'
  end
end
