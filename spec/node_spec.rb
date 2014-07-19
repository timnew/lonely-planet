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

  describe Node::XmlVisitor do
    it 'should invoke element enter callback' do
      mock(subject).enter_example({})

      subject.start_element 'example', []
    end

    it 'should parse attributes for element' do
      mock(subject).enter_example({name:'cool'})

      subject.start_element 'example', [['name', 'cool']]
    end

    it 'should invoke element leave callback' do
      mock(subject).leave_example

      subject.end_element 'example'
    end

    it 'should invoke element text callback' do
      mock(subject).example_text('cool')

      subject.start_element 'example', []
      subject.characters 'cool'
    end
  end
end