describe DestinationVisitor do
  let(:listener) { double }

  subject do
    DestinationVisitor.new listener
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
      destination[:history][:history].values[:history].should contain_exactly 'some text'
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

  it 'should ignore the destinations that not included' do
    allow(listener).to receive(:included?).with(an_instance_of(String)) { |id| id == '10010' }
    expect(listener).to receive(:new_destination).with(an_instance_of(Destination)).once do |destination|
      destination.atlas_id.should == '10010'
    end

    subject.start_element 'destination', [['atlas_id', '355064'], ['title', 'Africa'], ['title-ascii', 'africa']]
    subject.end_element 'destination'

    subject.start_element 'destination', [['atlas_id', '10010'], ['title', 'Beijing'], ['title-ascii', 'beijing']]
    subject.end_element 'destination'

    subject.start_element 'destination', [['atlas_id', '232323'], ['title', 'Atalantic'], ['title-ascii', 'atlantic']]
    subject.end_element 'destination'
  end
end