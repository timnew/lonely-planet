class ViewModelBuilder
  module DSL
    def build(something, &block)
      if something.is_a? Class
        klass = something
      else
        klass = something.class
      end

      if klass.const_defined? :Builder
        builder_class = klass.const_get :Builder
      else
        builder_class = ViewModelBuilder
      end

      builder_class
      .new(something, self)
      .execute(&block)
      .result
    end
  end
end