describe Block do

  describe 'initialize' do
    it 'should initialize with arguments' do
      paras = ['abc']
      subject = Block.new paras, limit: 5, heading: 'heading'

      subject.paragraphs.should contain_exactly *paras
      subject.limit.should == 5
      subject.heading.should == 'heading'
    end

    it 'should initialize with defaults' do
      subject.paragraphs.should be_an(Array).and be_empty
      subject.limit.should == 0
      subject.heading.should be_nil
    end

    it 'should set limit to paragraphs length if not assigned explicitly' do
      subject = Block.new %w(a b c)
      subject.limit.should == 3
    end
  end

  it 'should check heading existence' do
    subject.has_heading?.should be_falsey

    subject.heading = 'heading'

    subject.has_heading?.should be_truthy
  end

  it 'should check content existence' do
    subject.has_content?.should be_falsey

    subject.paragraphs = %w(a b c)

    subject.has_content?.should be_truthy
  end

  it 'should check extra existence' do
    subject.has_content?.should be_falsey

    subject.paragraphs = %w(a b c)

    subject.has_content?.should be_truthy
  end

  it 'should generate paragraph attributes' do
    subject = Block.new %w(a b c), limit: 2
    subject.paragraph_attr(0).should == {}
    subject.paragraph_attr(1).should == {}
    subject.paragraph_attr(2).should ==  {class: 'extra', style: 'display: none;'}
  end
end
