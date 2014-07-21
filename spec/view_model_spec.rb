describe ViewModelBuilder do

  include ViewModelBuilder::DSL

  class SampleClass
    attr_accessor :value, :external_value
    extend ViewModelBuilder::DSL
  end

  let(:external) do
    double
  end

  it 'should work', :smoke do
    instance = build(SampleClass) do
      value 'value'
      external_value external
    end

    instance.should be_an_instance_of SampleClass
    instance.value.should == 'value'
    instance.external_value.should == external
  end
end