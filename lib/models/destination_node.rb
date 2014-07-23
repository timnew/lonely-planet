class DestinationNode < Node

  attr_reader :values

  def initialize(name)
    super name

    @values = Hash.new do |hash, key|
      hash[key] = []
    end
  end

  def add_value(name, value)
    values[name.to_sym] << value
  end

  def has_value?(name)
    values.has_key? name.to_sym
  end

  def method_missing(name, *args, &block)
    return children[name.to_sym] if has_child? name
    super
  end
end
