describe ViewModelBuilder do

  include ViewModelBuilder::DSL

  class ViewModel
    attr_accessor :value, :external_value
    extend ViewModelBuilder::DSL
  end

  class ViewModelWithBuilder
    class Builder < ViewModelBuilder

    end
  end

  let(:external) do
    double
  end

  it 'should work' do
    instance = build(ViewModel) do
      value 'value'
      external_value external
    end

    instance.should be_an_instance_of ViewModel
    instance.value.should == 'value'
    instance.external_value.should == external
  end

  it 'should build instance' do
    instance = ViewModel.new

    build(instance) do
      value 'value'
      external_value external
    end

    instance.value.should == 'value'
    instance.external_value.should == external
  end

  it 'should instantiate specific builder' do
    build(ViewModelWithBuilder) do
      self.should be_an_instance_of ViewModelWithBuilder::Builder
    end
  end

  it 'should infer specific builder from instance class' do
    instance = ViewModelWithBuilder.new

    build(instance) do
      self.should be_an_instance_of ViewModelWithBuilder::Builder
    end
  end
end