describe TaxonomyVisitor do
  let(:nodes) { subject.nodes }
  let(:first_node) { nodes.values.first }

  it 'should instantiate node' do
    subject.start_element 'node', [['atlas_node_id', '1']]

    first_node.should be_an_instance_of TaxonomyNode
    first_node.atlas_id.should == '1'
  end

  it 'should create node hierarchy' do
    subject.start_element 'node', [['atlas_node_id', '1']]

    subject.start_element 'node', [['atlas_node_id', '11']]
    subject.end_element 'node'

    subject.start_element 'node', [['atlas_node_id', '12']]
    subject.end_element 'node'

    subject.end_element 'node'

    first_node.atlas_id.should == '1'
    first_node.parent.should be_nil

    first_node.children.length.should == 2
    
    first_node.children[:'11'].atlas_id.should == '11'
    first_node.children[:'11'].parent.should == first_node

    first_node.children[:'12'].atlas_id.should == '12'
    first_node.children[:'12'].parent.should == first_node
  end

  it 'should populate all nodes' do
    subject.start_element 'node', [['atlas_node_id', '1']]

    subject.start_element 'node', [['atlas_node_id', '11']]
    subject.end_element 'node'

    subject.start_element 'node', [['atlas_node_id', '12']]
    subject.end_element 'node'

    subject.end_element 'node'

    nodes.length.should == 3

    nodes['1'].atlas_id.should == '1'
    nodes['11'].atlas_id.should == '11'
    nodes['12'].atlas_id.should == '12'
  end
end
