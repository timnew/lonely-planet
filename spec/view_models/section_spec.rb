describe Section do

  let(:title) { 'title' }
  let(:paras) { %w{a b c} }

  it 'should initialize title' do
    subject = Section.new title do
    end

    subject.title.should == title
  end

  it 'should create text block' do
    subject = Section.new title do
      block %w(a b c)
    end

    subject.blocks.length.should == 1
    block = subject.blocks.first

    block.paragraphs.should contain_exactly *paras
    block.heading.should be_nil
    block.limit.should == 3
  end

  it 'should create heading block with limit' do
    subject = Section.new title do
      block 'heading', %w(a b c), limit: 5
    end

    subject.blocks.length.should == 1
    block = subject.blocks.first

    block.paragraphs.should contain_exactly *paras
    block.heading.should == 'heading'
    block.limit.should == 5
  end

  it 'should create extra block without heading' do
    subject = Section.new title do
      extra_block %w(a b c)
    end

    subject.blocks.length.should == 1
    block = subject.blocks.first

    block.paragraphs.should contain_exactly *paras
    block.heading.should be_nil
    block.limit.should == 0
  end

  it 'should create extra block' do
    subject = Section.new title do
      extra_block 'heading', %w(a b c)
    end

    subject.blocks.length.should == 1
    block = subject.blocks.first

    block.paragraphs.should contain_exactly *paras
    block.heading.should == 'heading'
    block.limit.should == 0
  end
end
