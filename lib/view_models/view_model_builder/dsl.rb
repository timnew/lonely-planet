class ViewModelBuilder
  module DSL
    def build(klass, &block)
      ViewModelBuilder
      .new(klass, self)
      .execute(&block)
      .result
    end
  end
end