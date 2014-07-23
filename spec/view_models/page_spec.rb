describe Page do
  let(:taxonomy_node) { double }
  let(:destination) { double }
  subject { Page.new('', '', taxonomy_node, destination) }

  xit 'should get path' do
    expect(taxonomy_node).to receive(:get_path).and_return('Africa/South Africa/Cape Town')

    subject.get_path.should == 'Africa/South Africa/Cape Town'
  end
end