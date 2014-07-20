describe Node do
  it 'should initialize children with given value' do
    node = Node.new 'name', Hash.new('super')

    node[:a].should == 'super'
  end

  it 'should has [], []=, length as same as children' do
    node = Node.new 'name'

    node.length.should == 0

    node[:a] = 'super'
    node.children[:a].should == 'super'

    node.children[:a] = 'cool'
    node[:a].should == 'cool'

    node.length.should == 1
  end

  describe 'add child' do
    it 'should add child' do
      parent = Node.new 'parent'
      child = Node.new 'example'

      parent.add_child child, 'child'

      parent.children[:child].should == child
      child.parent.should == parent
    end

    it 'should infer child name' do
      parent = Node.new 'parent'
      child = Node.new 'child'

      parent.add_child child

      parent.children[:child].should == child
      child.parent.should == parent
    end
  end

  it 'should create child with same type' do
    class SampleNode < Node
    end

    parent = SampleNode.new 'sample'

    child = parent.create_child 'child'

    child.should be_an_instance_of SampleNode
    parent.children[:child].should == child
    child.parent.should == parent
    child.name.should == 'child'
  end
end