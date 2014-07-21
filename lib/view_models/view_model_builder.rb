class ViewModelBuilder
  # ViewModelBuilder.new(Section)
  # ViewModelBuilder.new(Section.new)
  def initialize(something, host)
    if something.is_a?(Class)
      @result = something.new
    else
      @result = something
    end

    @host = host
  end

  def execute(&block)
    instance_eval(&block)
    self
  end

  def result
    @result
  end

  def respond_to?(symbol, include_private = false)
    return true if super
    return true if @result.respond_to?(:"#{name}=")
    not @host.nil? and @host.respond_to?(symbol)
  end

  def method_missing(name, *args, &block)
    if @result.respond_to?(:"#{name}=")
      @result.send :"#{name}=", *args
    elsif not @host.nil? and @host.respond_to?(name)
      @host.send name, *args, &block
    else
      super
    end
  end
end