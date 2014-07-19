describe Node do 
  it 'should create child' do
    parent = Node.new

    child = parent.create_child

    parent.children.first.should == child
    child.parent.should == parent
  end
end