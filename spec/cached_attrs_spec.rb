describe CachedAttrs do

  class TargetClass
    extend CachedAttrs

    attr_reader :nil_attr_counter

    def initialize
      @number = 0
      @nil_attr_counter = 0
    end

    cached_attr :value do
      'value'
    end

    cached_attr :cached_number do
      @number += 1
    end

    cached_attr :proxy_method do
      actual_method
    end

    cached_attr :nil_attr do
      @nil_attr_counter += 1
      nil
    end

    cached_attr :some_boolean? do
      'value' # avoid to use boolean to ensure the test is not fooled by boolean's loose equality rule
    end

    cached_attr :some_dangerous! do
      'value'
    end

    private

    def actual_method
      'actual'
    end
  end

  subject { TargetClass.new }

  it 'should define attribute and yield value from block' do
    subject.should respond_to :value
    subject.value.should == 'value'
  end

  it 'should yield block in instance context' do
    subject.proxy_method.should == 'actual'
  end

  it 'should cached value after first time evaluate' do
    num = subject.cached_number
    subject.cached_number.should == num
  end

  it 'should also cached nil value' do
    subject.nil_attr_counter.should == 0
    subject.nil_attr.should == nil
    subject.nil_attr_counter.should == 1
    subject.nil_attr.should == nil
    subject.nil_attr_counter.should == 1
  end

  it 'should escape ? and ! in method name' do
    subject.some_boolean?.should == 'value'
    subject.some_dangerous!.should == 'value'
  end
end