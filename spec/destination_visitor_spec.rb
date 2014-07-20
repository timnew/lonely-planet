class SimpleListener
  attr_accessor :destinations

  def initialize
    @destinations = []
  end

  def last_destination
    destinations.last
  end

  def new_destination(dest)
    destinations << dest
  end
end

describe Destination::Visitor do
  let(:listener){ SimpleListener.new }
  let(:destination) { listener.last_destination }

  subject do
    Destination::Visitor.new listener
  end

  it 'should invoke callback' do
    subject.start_element 'destination', [['atlas_id', '355064'], ['title', 'Africa'], ['title-ascii', 'africa']]
    subject.end_element 'destination'

    destination.atlas_id.should == '355064'
    destination.title.should == 'Africa'
    destination.title_ascii.should == 'africa'
  end

  it 'should handle same-named nested elements', :wip do
    subject.start_element 'destination', [['atlas_id', '355064'], ['title', 'Africa'], ['title-ascii', 'africa']]
    subject.start_element 'history'
    subject.start_element 'history'
    subject.start_element 'history'
    subject.cdata_block 'some text'
    subject.end_element 'history'
    subject.end_element 'history'
    subject.end_element 'history'
    subject.end_element 'destination'

    destination.history.history.values[:history].should contain_exactly 'some text'

  end


end