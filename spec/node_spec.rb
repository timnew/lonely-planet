describe Node do

  it 'should add child' do
    parent = Node.new
    child = Node.new

    parent.add_child child

    parent.children.first.should == child
    child.parent.should == parent
  end

  it 'should create child with same type' do
    class SampleNode < Node
    end

    parent = SampleNode.new

    child = parent.create_child

    child.should be_an_instance_of SampleNode
    parent.children.first.should == child
    child.parent.should == parent
  end
end