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

  describe 'factory methods' do

    let(:xml) { File.join(File.dirname(__FILE__), '../../destinations.xml') }

    let(:destinations) { [] }

    def include?(atlas_id)
      atlas_id == '355064'
    end

    def new_destination(destination)
      destinations << destination
    end

    it 'should load from file', :smoke do
      Destination.load(self, xml)

      destinations.length.should == 1
      destinations.first.atlas_id.should == '355064'
    end
  end
end
