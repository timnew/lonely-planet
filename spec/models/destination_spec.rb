describe Destination do
  subject do
    Destination.new atlas_id: '10010', title: '中国', :'title-ascii' => 'China'
  end

  it 'should should initialize destination' do
    subject.name.should == 'Destination'
    subject.atlas_id.should == '10010'
    subject.title.should == '中国'
    subject.title_ascii.should == 'China'
  end

  it 'should create child as DestinationNode'do
    subject.create_child('sample').should be_an_instance_of DestinationNode
  end
end
