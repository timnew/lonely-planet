describe Node do
  subject do
    Node.new 'root'
  end

  it 'should initialize children with given value' do
    subject = Node.new 'name', Hash.new('super')

    subject[:a].should == 'super'
  end

  it 'should has [], []=, length as same as children' do
    subject.length.should == 0

    subject[:a] = 'super'
    subject.children[:a].should == 'super'

    subject.children[:a] = 'cool'
    subject[:a].should == 'cool'

    subject.length.should == 1
  end

  describe 'add child' do
    let(:parent) { Node.new 'parent' }
    let(:child) { Node.new 'child' }

    it 'should add child' do

      parent.add_child child, 'new_child'

      parent.children[:new_child].should == child
      child.parent.should == parent
    end

    it 'should infer child name' do

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

  describe 'retrieve child recursively' do
    it 'should retrieve child' do
      subject.create_child('a').create_child('b').create_child('c')
      subject[:a, :b, :c].name.should == 'c'
    end

    it 'should yield nil when child not exists' do
      subject.create_child('a').create_child('b').create_child('c')
      subject[:a, :b, :d].should be_nil
    end

    it 'should yield nil when path not exists' do
      subject[:a, :b, :c].should be_nil
    end
  end

end