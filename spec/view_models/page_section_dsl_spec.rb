describe Page do

  let(:introduction) {
    double
  }

  let(:animals) do
    double
  end

  let(:destination) do
    result = double

    allow(result).to receive(:has_child?).with(:introductory) { true }
    allow(result).to receive(:has_child?).with(:wildlife) { true }
    allow(result).to receive(:[]).with(:introductory, :introduction) { introduction }
    allow(result).to receive(:[]).with(:wildlife, :animals) { animals }
    allow(result).to receive(:[]).with(:wildlife, :aliens) { nil }

    result
  end

  subject do
    Page.new '/', TaxonomyNode.new('10010'), destination
  end

  before(:each) do
    subject.instance_eval do
      @sections = []
    end
  end

  it 'should build sections as expected' do
    subject.instance_eval do

      section :introductory, :introduction do |introduction|
        introduction
      end

      section :wildlife, :animals

      section :wildlife, :aliens do |aliens|
        aliens
      end

      section :wildlife, :animals do |animals|
        animals
      end
    end

    subject.sections.should contain_exactly introduction, animals
  end
end
