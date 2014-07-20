describe Destination::Visitor do
  let(:listener) { double }

  subject do
    Destination::Visitor.new listener
  end

  it 'should invoke callback' do
    allow(listener).to receive(:included?).with(an_instance_of(String)).and_return(true)
    expect(listener).to receive(:new_destination).with(an_instance_of(Destination)) do |destination|
      destination.atlas_id.should == '355064'
      destination.title.should == 'Africa'
      destination.title_ascii.should == 'africa'
    end

    subject.start_element 'destination', [['atlas_id', '355064'], ['title', 'Africa'], ['title-ascii', 'africa']]
    subject.end_element 'destination'
  end

  it 'should handle same-named nested elements' do
    allow(listener).to receive(:included?).with(an_instance_of(String)).and_return(true)
    expect(listener).to receive(:new_destination).with(an_instance_of(Destination)) do |destination|
      destination.history.history.values[:history].should contain_exactly 'some text'
    end

    subject.start_element 'destination', [['atlas_id', '355064'], ['title', 'Africa'], ['title-ascii', 'africa']]
    subject.start_element 'history'
    subject.start_element 'history'
    subject.start_element 'history'
    subject.cdata_block 'some text'
    subject.end_element 'history'
    subject.end_element 'history'
    subject.end_element 'history'
    subject.end_element 'destination'
  end
end