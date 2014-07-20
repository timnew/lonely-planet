describe Node do
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
      def initialize(name)
        super name
      end
    end

    parent = SampleNode.new 'sample'

    child = parent.create_child 'child'

    child.should be_an_instance_of SampleNode
    parent.children[:child].should == child
    child.parent.should == parent
    child.name.should == 'child'
  end
end