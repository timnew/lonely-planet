describe DestinationNode do

  subject do
    DestinationNode.new 'node'
  end

  it 'should add value' do
    subject.add_value('overview', 'text')

    subject.values[:overview].should contain_exactly 'text'
  end

  it 'should add multiple values' do
    subject.add_value('history', 'history1')
    subject.add_value('history', 'history2')
    subject.add_value('history', 'history3')

    subject.values[:history].should contain_exactly 'history1', 'history2', 'history3'
  end

  it 'should check child value' do
    subject.has_value?('sample').should be_falsey

    subject.add_value('sample', 'cool')

    subject.has_value?('sample').should be_truthy
  end

  describe 'children as attribute reader' do
    it 'should treat child node as method' do
      subject.create_child 'sample'
      subject.sample.should be_an_instance_of DestinationNode
      subject.sample.name.should == 'sample'
    end

    it 'should raise method missing exception' do
      expect { subject.not_exist }.to raise_error NoMethodError
    end
  end

end

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
