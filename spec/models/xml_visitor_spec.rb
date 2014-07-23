describe XmlVisitor do

  describe 'traversal status attributes' do

    it 'should populate current_element and parent_element' do
      subject.start_element 'level1'

      subject.current_element.should == 'level1'
      subject.parent_element.should be_nil

      subject.start_element 'level2'

      subject.current_element.should == 'level2'
      subject.parent_element.should == 'level1'

      subject.end_element 'level2'

      subject.current_element.should == 'level1'
      subject.parent_element.should be_nil
    end

    it 'should populate current_node and parent_node' do
      subject.node_stack.push 'node'

      subject.current_node.should == 'node'
      subject.parent_node.should be_nil

      subject.node_stack.push 'new node'
      subject.current_node.should == 'new node'
      subject.parent_node.should == 'node'

      subject.node_stack.pop
      subject.current_node.should == 'node'
      subject.parent_node.should be_nil
    end

    it 'should populate root_node after initialized' do
      subject = XmlVisitor.new
      subject.root_node.should be_nil

      subject.node_stack.push 'node'
      subject.root_node.should == 'node'
    end

  end

  describe 'delegate_to method' do
    it 'should ignore if name is null' do
      subject.delegate_to nil
    end
  end

  describe 'enter element callback' do
    it 'should invoke element enter callback' do
      expect(subject).to receive(:enter_example).with({})

      subject.start_element 'example', []
    end

    it 'should parse attributes for element' do
      expect(subject).to receive(:enter_example).with({name: 'cool'})

      subject.start_element 'example', [['name', 'cool']]
    end

    it 'should invoke generic enter' do
      expect(subject).to receive(:generic_enter).with('example', {name: 'cool'})

      subject.start_element 'example', [['name', 'cool']]
    end
  end

  describe 'leave element callback' do
    it 'should invoke element leave callback' do
      expect(subject).to receive(:leave_example)

      subject.end_element 'example'
    end

    it 'should invoke generic element leave callback' do
      expect(subject).to receive(:generic_leave).with('example')

      subject.end_element 'example'
    end
  end

  it 'should invoke element text callback' do
    expect(subject).to receive(:example_text).with('cool')

    subject.start_element 'example', []
    subject.characters 'cool'
  end

  describe 'cdata callback' do

    it 'should invoke element cdata callback' do
      expect(subject).to receive(:example_cdata).with('cool')

      subject.start_element 'example', []
      subject.cdata_block 'cool'
    end

    it 'should invoke generic cdata callback' do
      expect(subject).to receive(:generic_cdata).with('cool')

      subject.start_element 'example', []
      subject.cdata_block 'cool'
    end
  end

  describe 'skip current element' do
    it 'should skip current element' do
      subject.start_element 'parent', []
      subject.start_element 'current', []

      subject.skip?.should be_falsey

      subject.skip_current_element

      subject.skip?.should be_truthy

      expect(subject).not_to receive(:current_text).with(any_args)
      subject.characters('something')

      expect(subject).not_to receive(:generic_cdata).with(any_args)
      subject.cdata_block('something')

      expect(subject).not_to receive(:generic_enter).with(any_args)
      subject.start_element 'child', []

      expect(subject).not_to receive(:skiped_text).with(any_args)
      subject.characters('something')

      expect(subject).not_to receive(:generic_cdata).with(anything)
      subject.cdata_block('something')

      expect(subject).not_to receive(:generic_leave).with(any_args)
      subject.end_element 'child'

      expect(subject).not_to receive(:generic_leave).with(any_args)
      subject.end_element 'current'

      subject.skip?.should be_falsey
    end
  end
end