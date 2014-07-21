class ViewModelBuilder
  module DSL
    def build(something, &block)
      if something.is_a? Class
        klass = something
      else
        klass = something.class
      end

      begin
        builder_class = klass.const_get :Builder # Enforce autoload if exists
      rescue NameError
        builder_class = ViewModelBuilder
      end

      builder_class
      .new(something, self)
      .execute(&block)
      .result
    end
  end
end