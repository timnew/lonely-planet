# PageMaker is an actor.
# Actor is the class that glues models, view models together as an application
# Testing actor as a black box leads to expensive functional test. To prepare and maintain fixtures are usually painful.
# On the other hand, since the behavior of models, view models involved are covered by their relatively cheap unit tests.
# So it is not that necessary to recheck them here in an expensive way.
# Also, since actor is very close to user, user can verify the function by run the app easily.
# So I prefer to test actor in a relatively cheap way, test it as a white box, just make sure each model are invoked properly.
describe PageMaker do

  let(:taxonomy_xml) { 'taxonomy.xml' }

  let(:destination_xml) { 'destinations.xml' }

  let(:root_path) { File.dirname(__FILE__) }

  let(:render) do
    render = double

    render
  end

  # noinspection RubyStringKeysInHashInspection
  let(:taxonomy_nodes) do
    {
        '10010' => taxonomy_node
    }
  end

  let(:taxonomy_node) { TaxonomyNode.new('10010') }

  let(:destination) do
    Destination.new atlas_id: '10010', title: 'China', :'title_ascii' => 'china'
  end

  subject do
    PageMaker.new root_path, render, taxonomy_xml, destination_xml
  end

  describe 'actor behaviros' do
    it 'should load taxonomy' do
      expect(TaxonomyNode).to receive(:load).with(taxonomy_xml).and_return(taxonomy_nodes)

      subject.load_taxonomy.should == subject #ensure the method chain is possible

      subject.taxonomy_nodes.should == taxonomy_nodes
    end

    it 'should run' do
      expect(Destination).to receive(:load).with(subject, destination_xml)

      subject.run
    end
  end

  describe 'destination visitor callbacks' do

    before(:each) do
      expect(TaxonomyNode).to receive(:load).with(taxonomy_xml).and_return(taxonomy_nodes)
      subject.load_taxonomy
    end

    it 'should filter unused destination' do
      subject.include?('10010').should be_truthy
      subject.include?('not_exist').should be_falsey
    end

    it 'should render page when destination is populated' do
      expect(render).to receive(:render) do |page|
        page.root_path.should == root_path
        page.taxonomy_node.should == taxonomy_node
        page.destination.should == destination
      end

      subject.new_destination destination
    end

  end
end