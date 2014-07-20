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
    describe 'delegate_to method' do
      it 'should ignore if name is null' do
        mock(subject)
        subject.delegate_to nil
      end
    end

    describe 'enter element callback' do
      it 'should invoke element enter callback' do
        mock(subject).enter_example({})

        subject.start_element 'example', []
      end

      it 'should parse attributes for element' do
        mock(subject).enter_example({name: 'cool'})

        subject.start_element 'example', [['name', 'cool']]
      end

      it 'should invoke generic enter' do
        mock(subject).generic_enter('example', {name: 'cool'})

        subject.start_element 'example', [['name', 'cool']]
      end
    end

    describe 'leave element callback' do
      it 'should invoke element leave callback' do
        mock(subject).leave_example

        subject.end_element 'example'
      end

      it 'should invoke generic element leave callback' do
        mock(subject).generic_leave('example')

        subject.end_element 'example'
      end
    end

    it 'should invoke element text callback' do
      mock(subject).example_text('cool')

      subject.start_element 'example', []
      subject.characters 'cool'
    end

    it 'should invoke element cdata callback' do
      mock(subject).example_cdata('cool')

      subject.start_element 'example', []
      subject.cdata_block 'cool'
    end

    describe 'current_element_path method' do
      it 'should build element path with depth 2 by default' do
        subject.start_element 'grand_parent', []
        subject.start_element 'parent', []
        subject.start_element 'example', []
        subject.current_element_path.should == 'parent_example'
      end

      it 'should build element path with specific depth' do
        subject.start_element 'grand_parent', []
        subject.start_element 'parent', []
        subject.start_element 'example', []
        subject.current_element_path(3).should == 'grand_parent_parent_example'
      end

      it 'should not raise exception if depth is not enough' do
        subject.start_element 'example', []
        subject.current_element_path(3).should be_nil
      end
    end
  end
end