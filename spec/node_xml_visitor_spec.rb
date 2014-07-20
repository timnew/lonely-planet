describe XmlVisitor do

  describe 'traversal status attributes' do

    it 'should populate current_element and current_parent' do
      subject.start_element 'level1'

      subject.current_element.should == 'level1'
      subject.current_parent.should be_nil

      subject.start_element 'level2'

      subject.current_element.should == 'level2'
      subject.current_parent.should == 'level1'

      subject.end_element 'level2'

      subject.current_element.should == 'level1'
      subject.current_parent.should be_nil
    end

    it 'should populate current_node' do
      subject.node_stack.push 'node'

      subject.current_node.should == 'node'

      subject.node_stack.push 'new node'
      subject.current_node.should == 'new node'

      subject.node_stack.pop
      subject.current_node.should == 'node'
    end

    describe 'root_node' do
      it 'should initialize root_node in initializer' do
        subject = XmlVisitor.new 'node'
        subject.root_node.should == 'node'

        subject.node_stack.push 'new node'
        subject.root_node.should == 'node'
      end

      it 'should populate root_node after initialized' do
        subject = XmlVisitor.new
        subject.root_node.should be_nil

        subject.node_stack.push 'node'
        subject.root_node.should == 'node'
      end
    end
  end

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

  describe 'cdata callback' do

    it 'should invoke element cdata callback' do
      mock(subject).example_cdata('cool')

      subject.start_element 'example', []
      subject.cdata_block 'cool'
    end

    it 'should invoke generic cdata callback' do
      mock(subject).generic_cdata('cool')

      subject.start_element 'example', []
      subject.cdata_block 'cool'
    end
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